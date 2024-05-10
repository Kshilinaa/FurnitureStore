//
//  FilterView.swift
//  FurnitureStore
//
import SwiftUI

/// Экран с фильтрами товара
struct FilterView: View {
    //MARK: - Constants
    private enum Constants {
        static let chevronLeft = "chevron.left"
        static let chevronForward = "chevron.forward"
        static let notihingSelected = "please choose"
        static let categoryTitle = "Category"
        static let nameTitle = "Your Name"
        static let cityTitle = "City"
        static let pricesTitle = "Prices"
        static let filtersTitle = "Filters"
        static let textColor = "textColor"
        static let moreTitle = "More"
        static let colorTitle = "Color - "
        static let dollarSign = "$"
        static let step = 500.0
        static let priceRange = 500.0...5000.0
        static let currentPrice = 3500.0
    }
    
    /// Прогресс слайдера для цены
    @State private var priceProgress = Constants.currentPrice
    /// Выбранный цвет
    @State private var selectedColor: Color?
    /// ViewModel для управления данными фильтров
    @ObservedObject var filterViewModel = FilterViewModel()
    /// Режим для управления отображением этого экрана
    @Environment(\.presentationMode) var presentationMode
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            headerView
                .ignoresSafeArea(.all, edges: .top)
            VStack {
                categoryView
                    .frame(height: 180)
                pricesSliderView
                paletteColorsView
            }.padding(.bottom, 80)
        }
        .padding(.top, -70)
        .onAppear() {
            UISlider.appearance().minimumTrackTintColor = .customLightGreen
            UISlider.appearance().setThumbImage(.thumb, for: .normal)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: Constants.chevronLeft)
                        .tint(.white)
                })
            }
            ToolbarItem(placement: .principal) {
                Text(Constants.filtersTitle)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
        }
    }
    // MARK: - Visual Components
    private var headerView: some View {
        VStack {
            LinearGradient(colors: [.topGragient, .bottomGradient], startPoint: .leading, endPoint: .trailing)
                .frame(height: 150)
        }
    }
    
    private var pricesSliderView: some View {
        VStack(alignment: .leading) {
            Text(Constants.pricesTitle)
                .fontWeight(.bold)
                .font(.system(size: 22))
                .foregroundStyle(Color(Constants.textColor))
                .padding(.leading)
            Slider(value: $priceProgress, in: Constants.priceRange, step: Constants.step)
                .padding(.horizontal)
            HStack {
                let minAmount = String(Int(Constants.priceRange.lowerBound))
                let maxAmount = String(Int(priceProgress))
                Text(Constants.dollarSign + minAmount)
                Spacer()
                Text(Constants.dollarSign + maxAmount)
            }
            .padding(.horizontal)
            .font(.system(size: 18))
            .offset(y: -10)
        }
    }
    
    private var categoryView: some View {
        VStack(spacing: 1) {
            HStack {
                Text(Constants.categoryTitle)
                    .fontWeight(.bold)
                    .font(.system(size: 22))
                    .foregroundStyle(Color(Constants.textColor))
                Spacer()
                Group {
                    Text(Constants.moreTitle)
                        .fontWeight(.bold)
                        .font(.system(size: 22))
                        .foregroundStyle(.gray)
                    Image(systemName: Constants.chevronForward)
                        .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal)
            ScrollView(.horizontal) {
                let rows = [GridItem()]
                LazyHGrid(rows: rows, spacing: 12, content: {
                    ForEach(filterViewModel.categories, id: \.self) { category in
                        makeCategoryView(category)
                    }
                })
            }
        }
    }
    
    
    private var paletteColorsView: some View {
        VStack(alignment: .leading) {
            Text(Constants.colorTitle + selectedColorDescription)
                .fontWeight(.bold)
                .foregroundStyle(Color(Constants.textColor))
                .font(.system(size: 24))
                .padding(.leading)
            
            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(filterViewModel.colors, id: \.self) { color in
                    CircleColorView(color: color, isSelected: color == selectedColor)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
            .padding()
        }
    }

    struct CircleColorView: View {
        var color: Color
        var isSelected: Bool
        
        var body: some View {
            Circle()
                .fill(color)
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: isSelected ? 3 : 1)
                )
                .frame(width: 40, height: 40)
        }
    }
    
    private var selectedColorDescription: String {
        if let selectedColor {
            return selectedColor.description.capitalized
        } else {
            return Constants.notihingSelected
        }
    }
    
    private func makeCategoryView(_ imageName: String) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.customWhite)
            .frame(width: 120, height: 80)
            .shadow(radius: 3, y: 3)
            .overlay(
                Image(imageName)
                    .frame(width: 50, height: 50)
            )
    }
    
}

struct FiltersViewPreviews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}

