//
//  MainTabView.swift
//  FurnitureStore
//
//  Created by Ксения Шилина on 09.05.2024.
//

import SwiftUI

/// Главный таб бар приложения
struct MainTabView: View {
    enum Constants {
        static let profileTabIcon = "profileTabbar"
        static let basketTabIcon = "basketTabbar"
        static let storeTabIcon = "storeTabbar"
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            TabView {
                
                CatalogView()
                    .tabItem {
                        Image(Constants.storeTabIcon)
                            .renderingMode(.template)
                    }
                BasketView()
                    .tabItem {
                        Image(Constants.basketTabIcon)
                            .renderingMode(.template)
                    }
                ProfileView()
                    .tabItem {
                        Image(Constants.profileTabIcon)
                            .renderingMode(.template)
                    }
            }
            .onAppear {
                UITabBar.appearance().backgroundColor = .white
                UITabBar.appearance().barTintColor = .white
            }
            .tint(.priceColGreen)
        }
        
    }
}

struct MainTabViewPreviews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}


