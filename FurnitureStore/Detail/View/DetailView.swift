//
//  DetailView.swift
//  FurnitureStore
//
import SwiftUI

struct DetailView: View {
    //MARK: - Constants
    private enum Constants {
        static let reviewTitle = "Review"
        static let buyNowTitle = "Buy now"
        static let textColor = "textColor"
        static let plashkaForPrice = "plashkaForPrice"
        static let heartImage = "heart"
        static let heartFill = "heart.fill"
        static let priceTitle = "Price: "
        static let articleTitle = "Article: "
        static let description = "Description: "
        
    }
    @State private var isFavorite = false
    @State private var review = ""
    @State private var offset = 0
    @FocusState private var focused
    @ObservedObject var detailViewModel = DetailViewModel()
    @Environment(\.dismiss) private var dismiss

    //MARK: - Body
    var body: some View {
        VStack {
            productName
            productImg
            productPrice
            descriptionView
            
        }
        .onTapGesture {
            focused = false
        }
        .ignoresSafeArea(.keyboard)
    }
    // MARK: - Visual Components
    private var productName: some View {
        HStack {
            Text(detailViewModel.furniture[0].name)
                .fontWeight(.heavy)
                .font(.system(size: 20))
                .foregroundStyle(Color(Constants.textColor))
            Spacer()
            Button {
            } label: {
                Image(systemName: isFavorite ? Constants.heartFill : Constants.heartImage)
            }
            .foregroundStyle(.black)
        }
        .padding(.horizontal, 20)
    }
    
    private var productImg: some View {
        Image(detailViewModel.furniture[0].imageName)
    }
    
    private var productPrice: some View {
        Text("\(Constants.priceTitle) \(detailViewModel.furniture[0].price)$ ")
            .fontWeight(.heavy)
            .font(.system(size: 20))
            .foregroundStyle(Color(Constants.textColor))
            .padding(.vertical, 10)
            .padding(.horizontal, 25)
            .background(Color(Constants.plashkaForPrice))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(x: 8)
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private var descriptionView: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(colors: [.topGragient, .bottomGradient], startPoint: .top, endPoint: .bottom)
                )
                .ignoresSafeArea()
                .overlay(
                    VStack() {
                        textDescriptionView
                        Spacer().frame(height: 6)
                        textEditorView
                        buyNowButton
                    }
                        .padding(.top, 24)
                    
                )
            
        }
    }
    
    private var textDescriptionView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(Constants.articleTitle)
                    .fontWeight(.heavy)
                    .font(.system(size: 16))
                +
                Text(String(detailViewModel.furniture[0].article))
                    .font(.system(size: 16))
            }
            Spacer().frame(height: 6)
            HStack {
                Text(Constants.description)
                    .fontWeight(.heavy)
                    .font(.system(size: 16))
                +
                Text(detailViewModel.furniture[0].description)
                    .font(.system(size: 16))
            }
        }
    }
    
    private var textEditorView: some View {
        VStack {
            Text(Constants.reviewTitle)
                .font(.system(size: 16))
                .fontWeight(.bold)
            
            HStack(alignment: .top) {
                TextEditor(text: $detailViewModel.inputText)
                    .frame(width: 300, height: 177)
                    .scrollContentBackground(.hidden)
                    .multilineTextAlignment(.leading)
                    .focused($focused)
                    .onChange(of: focused) { newValue in
                        if newValue {
                            offset = -300
                        } else {
                            offset = 0
                        }
                    }
                VStack {
                    Spacer()
                        .frame(height: 10)
                    Text("\(detailViewModel.totalCharNumber)/300")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                    Spacer()
                }
            }
        }
        .foregroundStyle(.white)
    }
    
    private var buyNowButton: some View {
        Button {
            dismiss()
        } label: {
            Text(Constants.buyNowTitle)
                .fontWeight(.heavy)
                .font(.system(size: 20))
                .foregroundStyle(LinearGradient(colors: [.bottomGradient, .topGragient], startPoint: .top, endPoint: .bottom))
        }
        .tint(.white)
        .frame(width: 300, height: 55)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 27))
        .shadow(radius: 2, x: 0.0, y: 4.0)
        .padding(.bottom, 20)
    }
}

struct DetailViewPreviews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
