//
//  DetailViewModel.swift
//  FurnitureStore
//
import SwiftUI

class DetailViewModel: ObservableObject {
    //MARK: - Constants
    private enum Constants {
        static let sofaTitle = "Sofa Elda 900"
        static let imageName = "yellowSofa"
        static let descriptionTitle = "A sofa in a modern style is furniture without lush ornate decor.It has\na simple or even futuristic appearance and sleek design."
        static let reviewTitle = "This sofa looks great"
        static let article = 283564
        static let price = 999
    }
    @Published public var totalCharNumber = 0
    @Published public var inputText = "" {
        didSet {
            updateText()
        }
    }
    // MARK: - Public Properties
    public var lastText = ""
    public var furniture: [Furniture] = [Furniture(name: Constants.sofaTitle,
                                                   imageName: Constants.imageName,
                                                   price: Constants.price,
                                                   article: Constants.article,
                                                   description: Constants.descriptionTitle)]
    // MARK: - Private Properties
    private func updateText() {
        totalCharNumber = inputText.count
        if totalCharNumber <= 300 {
            lastText = inputText
        } else {
            inputText = lastText
        }
    }
}
