//
//  FilterViewModel.swift
//  FurnitureStore
//
import SwiftUI
/// Вью модель с фильтрами товаров
class FilterViewModel: ObservableObject {
    @Published var categories = ["bedFilter", "sofaFilter", "armchairFilter"]
    @Published var colors: [Color] = [.black, .white, .gray, .red, .green, .blue, .orange, .yellow, .pink, .purple, .primary, .secondary, .accentColor, .customWhite, .customBej, .customLightGreen, .customDarkGray, .customDarkGreen, .customGray, .customBrown
    ]
}
