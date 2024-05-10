//
//  InitialPageView.swift
//  FurnitureStore
//
//  Created by Ксения Шилина on 07.05.2024.
//

import SwiftUI

struct InitialPageView: View {
    // MARK: - Constants
    private enum Constants {
        static let upperTitle = "169.ru"
        static let getStartedButtonTitle = "Get Started"
        static let preRegistration = "Don't have an account?"
        static let registrationButtonTitle = "Sign in here"
    }
    
    // MARK: - State
    @State private var isShowingLoginView = false
    @State private var isShowingMainTabView = false
    
    // MARK: - Body
    var body: some View {
            NavigationView {
                ZStack {
                    creatingAGradient
                    VStack {
                        upperTitle
                        asyncImageView
                        Spacer().frame(height: 110)
                        getStartedButton
                        Spacer().frame(height: 70)
                        havingAnAccountTitle
                        singInButton
                    }
                    .fullScreenCover(isPresented: $isShowingLoginView) {
                        LoginView()
                    }
                    .fullScreenCover(isPresented: $isShowingMainTabView) {
                        MainTabView()
                    }
                }
            }
        }
    // MARK: - Visual Components
    private var asyncImageView: some View {
        AsyncImage(url: URL(string: "https://source.unsplash.com/401x401/?armchair")) { image in
            image
                .image?
                .resizable()
                .clipShape(Circle())
                .frame(width: 300, height: 300)
        }
    }
    private var creatingAGradient: some View {
        LinearGradient(colors: [Color("bottomGradient"), Color("topGragient")], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
    private var upperTitle: some View {
        Text(Constants.upperTitle)
            .foregroundStyle(.white)
            .fontWeight(.heavy)
            .font(.system(size: 40))
    }
    private var havingAnAccountTitle: some View {
        Text(Constants.preRegistration)
            .fontWeight(.heavy)
            .font(.system(size: 16))
            .foregroundStyle(.white)
    }
    private var singInButton: some View {
        Button(action: {
            isShowingLoginView = true
        }) {
            Text(Constants.registrationButtonTitle)
                .fontWeight(.heavy)
                .font(.system(size: 28))
                .foregroundStyle(.white)
                .padding(.top, -12)
        }
        .padding(.top, 12)
    }
    private var getStartedButton: some View {
        Button(action: {
            isShowingMainTabView = true
        }) {
            Text(Constants.getStartedButtonTitle)
                .fontWeight(.heavy)
                .font(.system(size: 20))
                .foregroundStyle(LinearGradient(colors: [Color("bottomGradient"), Color("topGragient")], startPoint: .top, endPoint: .bottom))
        }
        .tint(.white)
        .frame(width: 300, height: 55)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 27))
        .shadow(radius: 5, x: 0.0, y: 10.0)
    }
}

struct InitialPageViewPreviews: PreviewProvider {
    static var previews: some View {
        InitialPageView()
    }
}
