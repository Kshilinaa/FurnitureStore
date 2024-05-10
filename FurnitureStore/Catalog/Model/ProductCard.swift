//
//  ProductCard.swift
//  FurnitureStore
//
import Foundation
/// Настройка
struct ProductCard: Hashable {
    /// id
    var id = UUID()
    /// Имя
    let name: String
    /// Картинка продукта
    let productPicture: String
    /// Цена
    let price: String
    /// Новая цена
    let newPrice: Int
}
