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
    
    @Published var cocktailModel: [CocktailModel] = []
    @Published var cocktailState: CocktailState = .all
    @Published var errorMessage = ""
    @Published var apiLoading = true
    
    private let cocktailsAPI: CocktailsAPI
    
    init(cocktailsAPI: CocktailsAPI = FakeCocktailsAPI()) {
        self.cocktailsAPI = cocktailsAPI
        loadApi()
    }
    
    var filteredCocktails: [CocktailModel] {
        let cocktailData: [CocktailModel]
        switch cocktailState {
        case .all:
            cocktailData = cocktailModel
        case .alcoholic:
            cocktailData = cocktailModel.filter { $0.type == "alcoholic" }
        case .nonAlcoholic:
            cocktailData = cocktailModel.filter { $0.type != "alcoholic"  }
        }
        return cocktailData
    }
    
    func loadApi() {
        apiLoading = true
        cocktailsAPI.fetchCocktails { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let cocktailData):
                    self.cocktailModel = cocktailData
                    self.apiLoading = false
                case .failure(let error):
                    self.errorMessage = error.errorDescription
                }
                self.apiLoading = false
            }
        }
    }
}
