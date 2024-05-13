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
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.topGragient, .bottomGradient], startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                        .frame(height: 50)
                    Rectangle()
                        .fill(Color.white)
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
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true) // Hide back button
            .accentColor(.white) // Make back button white
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
                Image(systemName: "point")
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
            NavigationLink(destination: PaymentView()) {
                Rectangle()
            }
            .opacity(0)
            
            HStack {
                Image(systemName: setting.iconName)
                Text(setting.name)
                Spacer()
                if let badge = setting.badge {
                    Image(badge)
                }
            }
            .foregroundStyle(Color("textColor"))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
