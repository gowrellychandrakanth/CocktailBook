//
//  CocktailMainView.swift
//  CocktailBook
//
//  Created by Chandra Kanth on 07/03/25.
//

import SwiftUI

struct CocktailMainView: View {
    @StateObject private var viewModel = CocktailMainViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.apiLoading {
                ProgressView("Loading...")
                    .padding()
            } else if viewModel.cocktailList.isEmpty {
                VStack {
                    Text("No data available.")
                        .padding()
                    Button(action: {
                        viewModel.loadApi()
                    }) {
                        Text("Retry")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            } else {
                List(viewModel.filteredCocktails) { cocktail in
                    NavigationLink(destination: CocktailDetailView(
                        cocktailItem: cocktail,
                        cocktailTitle: viewModel.cocktailState.rawValue,
                        favouritesToggle: $viewModel.cocktailList[viewModel.cocktailList.firstIndex(where: { $0.id == cocktail.id })!].isFavourite,
                        cocktailDataHelper: viewModel.cocktailHelper
                    )) {
                        CocktailListItemView(cocktailItem: cocktail)
                    }
                }
                .navigationTitle(viewModel.cocktailState.rawValue)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Picker("Filter", selection: $viewModel.cocktailState) {
                            ForEach(CocktailMainViewModel.CocktailState.allCases, id: \.self) { state in
                                Text(state.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
        }
        .alert(isPresented: .constant(!viewModel.errorMessage.isEmpty)) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK")) {
                    viewModel.errorMessage = ""
                }
            )
        }
        .onAppear {
            viewModel.loadApi()
        }
    }
}

#Preview {
    CocktailMainView()
}
