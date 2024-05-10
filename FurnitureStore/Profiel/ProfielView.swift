//
//  ProfielView.swift
//  FurnitureStore
//
//  Created by Ксения Шилина on 08.05.2024.
//
import SwiftUI
/// Экран профиля пользователя
struct ProfileView: View {
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    // MARK: - Bbody
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.topGragient, .bottomGradient], startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                        .frame(height: 50)
                    Rectangle()
                        .fill(.white)
                        .ignoresSafeArea()
                        .overlay {
                            VStack {
                                profileInfo
                                Spacer()
                                    .frame(height: 47)
                                settingsList
                        }
                            
                    }
                }
            }
        }
    }
    // MARK: - Visual Components
    private var profileInfo: some View {
        VStack {
            Image("avatarProfile")
                .resizable()
                .clipShape(Circle())
                .frame(width: 160, height: 180)
            
            Text("Ksusha")
                .font(.system(size: 24, weight: .heavy))
                .foregroundStyle(Color("textColor"))
            HStack {
                Image(.point)
                Text("Moscow")
            }
        }
        .padding(.top, 45)
    }
    
    private var settingsList: some View {
        List(profileViewModel.allSettings, id: \.name) { setting in
            
            makeSettingCellView(setting: setting)
        }
        .listStyle(.plain)
        .padding(.horizontal, 40)
    }
    
    private func makeSettingCellView(setting: Setting) -> some View {
        ZStack {
            NavigationLink(destination: {
                Text("Account/Payment")
            }) {
                Rectangle()
            }
            .opacity(0)
            
            HStack {
                Image(setting.iconName)
                Text(setting.name)
                Spacer()
                Image(setting.badge ?? "")
                
            }
            .foregroundStyle(Color("textColor"))
        }
    }
}

struct ProfielViewPreviews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

