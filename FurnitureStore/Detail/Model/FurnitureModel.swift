//
//  Furniture.swift
//  FurnitureStore

import Foundation
struct Furniture: Hashable {
    /// Название мебели
    let name: String
    /// Название изображения мебели
    let imageName: String
    /// Цена мебели
    let price: Int
    /// Артикул мебели
    let article: Int
    /// Описание мебели
    let description: String
}
