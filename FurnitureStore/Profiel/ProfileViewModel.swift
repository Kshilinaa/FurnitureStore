//
//  ProfileViewModel.swift
//  FurnitureStore
//
//  Created by Ксения Шилина on 09.05.2024.
//
import Foundation

class ProfileViewModel: ObservableObject {
    /// Настройки профиля
    public var allSettings: [Setting] = [
        Setting(name: "Messages", iconName: "IconLetter", badge: "notification3"),
        Setting(name: "Notifications", iconName: "IconBell", badge: "notification4"),
        Setting(name: "Accounts Details", iconName: "IconProfile", badge: nil),
        Setting(name: "My purchases", iconName: "IconBasket", badge: nil),
        Setting(name: "Settings", iconName: "IconSettins", badge: nil)
    ]
    
}
