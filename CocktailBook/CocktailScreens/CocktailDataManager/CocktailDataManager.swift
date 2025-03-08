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
    
    /// Saves the given list of favorite cocktail IDs to UserDefaults.
    /// - Parameter favorites: An array of cocktail IDs to be stored.
    func saveData(_ favorites: [String]) {
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
    }
    
    /// Loads all stored favorite cocktail IDs from UserDefaults.
    /// - Returns: An array of favorite cocktail IDs. If no data exists, returns an empty array.
    func loadAll() -> [String] {
        return UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
    }
    
    /// Adds a cocktail ID to the favorites list, ensuring no duplicates are added.
    /// - Parameter id: The unique ID of the cocktail to be added.
    func addData(_ id: String) {
        var favoriteArr = loadAll()
        if !favoriteArr.contains(id) {
            favoriteArr.append(id)
            saveData(favoriteArr)
        }
    }
    
    /// Removes a cocktail ID from the favorites list if it exists.
    /// - Parameter id: The unique ID of the cocktail to be removed.
    func removeData(_ id: String) {
        var favoriteArr = loadAll()
        if let index = favoriteArr.firstIndex(of: id) {
            favoriteArr.remove(at: index)
            saveData(favoriteArr)
        }
    }
}
