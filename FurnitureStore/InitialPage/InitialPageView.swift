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
        static let developerInfo = "Разработчик Ксюшка в здании, всем хорошего дня и отличного настроения!!!"
        static let bottomGradient = "bottomGradient"
        static let topGradient = "topGradient"
        static let customDarkGreen = "customDarkGreen"
    }
    // MARK: - State
    @State private var isShowingLoginView = false
    @State private var isLoading = false
    @State private var showDeveloperInfo = false
    
    // MARK: - Animations
    @State private var upperTitleOpacity = 0.0
    @State private var asyncImageOpacity = 0.0
    @State private var getStartedButtonOpacity = 0.0
    @State private var preRegistrationOpacity = 0.0
    @State private var registrationButtonOpacity = 0.0
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                creatingAGradient
                VStack {
                    upperTitleView
                    asyncImageView
                    Spacer().frame(height: 110)
                    if isLoading {
                        loadingView
                    } else {
                        contentView
                    }
                }
                .fullScreenCover(isPresented: $isShowingLoginView) {
                    LoginView()
                }
                
                if showDeveloperInfo {
                    developerInfoView
                        .transition(.opacity)
                }
            }
        }
    }
    
    // MARK: - Visual Components
    private var upperTitleView: some View {
        Text(Constants.upperTitle)
            .foregroundStyle(.white)
            .fontWeight(.heavy)
            .font(.system(size: 40))
            .opacity(upperTitleOpacity)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    upperTitleOpacity = 1.0
                }
            }
    }
    
    private var asyncImageView: some View {
        AsyncImage(url: URL(string: "https://source.unsplash.com/401x401/?armchair")) { image in
            image
                .image?
                .resizable()
                .clipShape(Circle())
                .frame(width: 300, height: 300)
                .opacity(asyncImageOpacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0).delay(0.5)) {
                        asyncImageOpacity = 1.0
                    }
                }
        }
    }
    
    private var creatingAGradient: some View {
        LinearGradient(colors: [Color(Constants.bottomGradient), Color(Constants.topGradient)], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
    
    private var loadingView: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    isLoading = false
                    isShowingLoginView = true
                }
            }
    }
    
    private var contentView: some View {
        VStack {
            getStartedButton
            Spacer().frame(height: 70)
            havingAnAccountTitle
            signInButton
        }
    }
    
    private var havingAnAccountTitle: some View {
        Text(Constants.preRegistration)
            .fontWeight(.heavy)
            .font(.system(size: 16))
            .foregroundStyle(.white)
            .opacity(preRegistrationOpacity)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0).delay(1.5)) {
                    preRegistrationOpacity = 1.0
                }
            }
    }
    
    private var signInButton: some View {
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
        .opacity(registrationButtonOpacity)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).delay(2.0)) {
                registrationButtonOpacity = 1.0
            }
        }
    }
    
    private var getStartedButton: some View {
        Button(action: {
            isLoading = true
        }) {
            Text(Constants.getStartedButtonTitle)
                .fontWeight(.heavy)
                .font(.system(size: 20))
                .foregroundStyle(LinearGradient(colors: [Color(Constants.bottomGradient), Color(Constants.topGradient)], startPoint: .top, endPoint: .bottom))
        }
        .tint(.white)
        .frame(width: 300, height: 55)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 27))
        .shadow(radius: 5, x: 0.0, y: 10.0)
        .opacity(getStartedButtonOpacity)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).delay(1.0)) {
                getStartedButtonOpacity = 1.0
            }
        }
        .onLongPressGesture(minimumDuration: 0.5, maximumDistance: 10, pressing: { isPressing in
            if isPressing {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        showDeveloperInfo = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        withAnimation {
                            showDeveloperInfo = false
                        }
                    }
                }
            } else {
                showDeveloperInfo = false
            }
        }) {
        }
    }
    
    private var developerInfoView: some View {
        VStack {
            Text(Constants.developerInfo)
                .foregroundColor(.white)
                .padding()
                .background(Color(Constants.customDarkGreen).opacity(0.9))
                .cornerRadius(10)
                .padding()
        }
    }
}

struct InitialPageViewPreviews: PreviewProvider {
    static var previews: some View {
        InitialPageView()
    }
}
