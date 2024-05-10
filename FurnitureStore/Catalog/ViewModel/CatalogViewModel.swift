//
//  CatalogViewModel.swift
//  FurnitureStore
//
//  Created by Ксения Шилина on 09.05.2024.
//
import Foundation
import SwiftUI
/// ViewModel для  каталога товаров
class CatalogViewModel: ObservableObject {
    // MARK: - Public Properties
    /// Список всех продуктов
    @Published var allProducts: [ProductCard] = [
        ProductCard(name: "Sofa", productPicture: "sofa", price: "2000$", newPrice: 999),
        ProductCard(name: "Armchair", productPicture: "armchair", price: "200$", newPrice: 100),
        ProductCard(name: "Bed", productPicture: "bed", price: "2000$", newPrice: 900),
        ProductCard(name: "Table", productPicture: "table", price: "1200$", newPrice: 600),
        ProductCard(name: "Сhair", productPicture: "chair", price: "200$", newPrice: 99),
        ProductCard(name: "Wardrobe", productPicture: "wardrobe", price: "1100$", newPrice: 899)
    ]
    /// Количество продуктов в корзине
    @Published var quantityPerProduct: [UUID: Int] = [:]
    /// Увеличение количества продукта в корзине
    func increaseQuantity(_ productId: UUID) {
        if let quantity = quantityPerProduct[productId] {
            quantityPerProduct[productId] = quantity + 1
        } else {
            quantityPerProduct[productId] = 1
        }
    }
    /// Уменьшение количества продукта в корзине
    func decreaseQuantity(_ productId: UUID) {
        if let quantity = quantityPerProduct[productId], quantity > 0 {
            quantityPerProduct[productId] = quantity - 1
        }
    }
    /// Вычисление общей цены продуктов в корзине
    var totalPrice: Int {
        var total: Int = 0
        for (productId, quantity) in quantityPerProduct {
            if let product = allProducts.first(where: { $0.id == productId }) {
                total += product.newPrice * quantity
            }
        }
        return total
    }
}
