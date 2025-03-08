//
//  CocktailModel.swift
//  CocktailBook
//
//  Created by Chandra Kanth on 07/03/25.
//

import Foundation

struct CocktailModel: Identifiable, Codable {
    let id: String
    let name: String?
    let type: String?
    let shortDescription: String?
    let longDescription: String?
    let preparationMinutes: Int?
    let imageName: String?
    let ingredients: [String]?
    var isFavourite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id, name, type, shortDescription, longDescription, preparationMinutes, imageName, ingredients
    }
    
    init(id: String = UUID().uuidString,
         name: String? = nil,
         type: String? = nil,
         shortDescription: String? = nil,
         longDescription: String? = nil,
         preparationMinutes: Int? = nil,
         imageName: String? = nil,
         ingredients: [String]? = nil,
         isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.type = type
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.preparationMinutes = preparationMinutes
        self.imageName = imageName
        self.ingredients = ingredients
        self.isFavourite = isFavorite
    }
}

extension CocktailModel {
    var nameText: String {
        return name ?? ""
    }
}
