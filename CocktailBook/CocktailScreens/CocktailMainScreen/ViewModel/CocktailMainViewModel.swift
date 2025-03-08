//
//  CocktailMainViewModel.swift
//  CocktailBook
//
//  Created by Chandra Kanth on 07/03/25.
//

import Foundation

class CocktailMainViewModel: ObservableObject {
    
    enum CocktailState: String, CaseIterable {
        case all = "All Cocktails"
        case alcoholic = "Alcoholic"
        case nonAlcoholic = "Non-Alcoholic"
    }
    
    @Published var cocktailList: [CocktailModel] = []
    @Published var cocktailState: CocktailState = .all
    @Published var errorMessage = ""
    @Published var apiLoading = false
    
    private let cocktailsAPI: CocktailsAPI
    let cocktailHelper: CocktailDataManager
    
    init(cocktailsAPI: CocktailsAPI = FakeCocktailsAPI(), cocktailHelper: CocktailDataManager = CocktailDataManager()) {
        self.cocktailsAPI = cocktailsAPI
        self.cocktailHelper = cocktailHelper
        loadApi()
    }
    
    var filteredCocktails: [CocktailModel] {
        let filteredData = cocktailList.filter {
            switch cocktailState {
            case .all:
                return true
            case .alcoholic:
                return $0.type == "alcoholic"
            case .nonAlcoholic:
                return $0.type != "alcoholic"
            }
        }
        
        return filteredData.sorted {
            ($0.isFavourite == $1.isFavourite) ? ($0.nameText < $1.nameText) : $0.isFavourite
        }
    }
    
    func loadApi() {
        apiLoading = true
        cocktailsAPI.fetchCocktails { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let cocktailData):
                    /*Once the parsing is successful read vaules from CocktailDataManager and Update the selected Favorites in the List*/
                    self.cocktailList = cocktailData.map { cocktail in
                        var newValue = cocktail
                        newValue.isFavourite = self.cocktailHelper.loadAll().contains(cocktail.id)
                        return newValue
                    }
                case .failure(let error):
                    self.errorMessage = error.errorDescription
                }
                self.apiLoading = false
            }
        }
    }
}
