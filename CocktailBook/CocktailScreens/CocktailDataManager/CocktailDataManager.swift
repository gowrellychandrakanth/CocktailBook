//
//  CocktailHelper.swift
//  CocktailBook
//
//  Created by Chandra Kanth on 08/03/25.
//

import Foundation

protocol CocktailDataHandler {
    func saveData(_ favorites: [String])
    func loadAll() -> [String]
    func addData(_ id: String)
    func removeData(_ id: String)
}

class CocktailDataManager: CocktailDataHandler, ObservableObject {
    private let favoritesKey = "selectedFavoriteItem"
    
    func saveData(_ favorites: [String]) {
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
    }
    
    func loadAll() -> [String] {
        return UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
    }
    
    func addData(_ id: String) {
        var favoriteArr = loadAll()
        if !favoriteArr.contains(id) {
            favoriteArr.append(id)
            saveData(favoriteArr)
        }
    }
    
    func removeData(_ id: String) {
        var favoriteArr = loadAll()
        if let index = favoriteArr.firstIndex(of: id) {
            favoriteArr.remove(at: index)
            saveData(favoriteArr)
        }
    }
}
