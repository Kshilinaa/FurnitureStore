//
//  CatalogView.swift
//  FurnitureStore
//
//  Created by Ксения Шилина on 09.05.2024.
//
import SwiftUI

/// Экран каталога товаров
    struct CatalogView: View {
        //MARK: - Constants
        private enum Constants {
            static let priceLabel = "Your total price"
            static let glassImage = "glass"
            static let searchTitle = "Search..."
            static let filterImage = "filter"
            static let textColor = "textColor"
            static let priceGreenColor = "priceColGreen"
            static let backCellColor = "backCell"
        }
        /// Управление данными каталога
        @ObservedObject private var storeViewModel = CatalogViewModel()
        /// Флаг для отображения детальной информации о товаре
        @State private var showingDetail = false
        /// Текст поиска
        @State private var search = ""
        
        //MARK: - Body
        var body: some View {
            NavigationView {
                ZStack {
                    LinearGradient(colors: [.topGragient, .bottomGradient], startPoint: .leading, endPoint: .trailing)
                        .ignoresSafeArea()
                    VStack(alignment: .leading) {
                        Spacer()
                        searchField
                        Spacer().frame(height: 50)
                        Rectangle()
                            .fill(Color.white)
                            .ignoresSafeArea()
                            .overlay {
                                VStack {
                                    Spacer().frame(height: 20)
                                    productTotalPrice
                                    scrollView
                                }
                            }
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            }
            .sheet(isPresented: $showingDetail, content: {
                DetailView()
            })
        }
        // MARK: - Visual Components
        private var searchField: some View {
            HStack {
                HStack {
                    Image(Constants.glassImage)
                    TextField(Constants.searchTitle, text: $search)
                }
                .padding(10)
                .background(Color.white)
                .cornerRadius(24)
                Spacer().frame(width: 10)
                filterButton
            }
            .padding(.horizontal, 20)
        }
        
        private var productTotalPrice: some View {
            HStack {
                Text("\(Constants.priceLabel) \(storeViewModel.totalPrice)$")
                    .fontWeight(.heavy)
                    .font(.system(size: 20))
                    .foregroundColor(Color(Constants.textColor))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                    .background(Color(Constants.priceGreenColor))
                    .cornerRadius(10)
                    .padding(.trailing, 8)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        
        private var makeRoundedRectangle: some View {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(Constants.backCellColor))
                .frame(height: 150)
                .shadow(radius: 2, x: 0.0, y: 4.0)
                .padding(.horizontal, 15)
        }
        
        private var scrollView: some View {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(storeViewModel.allProducts, id: \.id) { product in
                        productView(for: product)
                    }
                }
            }
        }
        
        private func productView(for product: ProductCard) -> some View {
            Button(action: {
                showingDetail = true
            }) {
                ZStack {
                    makeRoundedRectangle
                    HStack {
                        productImage(for: product)
                        productDetails(for: product)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
        
        private func productImage(for product: ProductCard) -> some View {
            Image(product.productPicture)
                .resizable()
                .frame(width: 140, height: 140)
        }
        
        private func productDetails(for product: ProductCard) -> some View {
            VStack(alignment: .leading) {
                Text(product.name)
                    .fontWeight(.bold)
                    .font(.title)
                priceDetails(for: product)
                quantityControl(for: product)
            }
        }
        
        private func priceDetails(for product: ProductCard) -> some View {
            HStack {
                Text("\(product.newPrice)$")
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
                    .padding(.leading, 8)
                    .font(.title)
                Text(product.price)
                    .foregroundColor(Color.gray)
                    .strikethrough()
                    .font(.title)
            }
        }
        
        private func quantityControl(for product: ProductCard) -> some View {
            HStack {
                Spacer()
                Button(action: {
                    storeViewModel.decreaseQuantity(product.id)
                }) {
                    Image(systemName: "minus")
                        .padding(10)
                        .fontWeight(.bold)
                        .foregroundColor(Color(Constants.textColor))
                        .clipShape(Circle())
                }
                
                Text("\(storeViewModel.quantityPerProduct[product.id] ?? 0)")
                    .fontWeight(.bold)
                
                Button(action: {
                    storeViewModel.increaseQuantity(product.id)
                }) {
                    Image(systemName: "plus")
                        .fontWeight(.bold)
                        .foregroundColor(Color(Constants.textColor))
                        .padding(10)
                        .clipShape(Circle())
                }
            }
            .cornerRadius(20)
        }
        
        private var filterButton: some View {
            NavigationLink(destination: FilterView()) {
                Image(Constants.filterImage)
            }
        }
    }

    struct CatalogViewPreviews: PreviewProvider {
        static var previews: some View {
            CatalogView()
        }
    }
