//
//  CocktailDetailView.swift
//  CocktailBook
//
//  Created by Chandra Kanth on 08/03/25.
//

import SwiftUI

struct CocktailDetailView: View {
    let cocktail: CocktailModel
    let cocktailTitle: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    if let preparationMinutes = cocktail.preparationMinutes {
                        HStack {
                            Image(systemName: "clock")
                            Text("\(preparationMinutes) Minutes")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding([.leading, .trailing])
                    }
                    
                    if let imageName = cocktail.imageName {
                        HStack {
                            Spacer()
                            
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                            Spacer()
                        }
                    }
                    
                    if let longDescription = cocktail.longDescription {
                        Text(longDescription)
                            .padding()
                    }
                    
                    Text("Ingredients")
                        .font(.headline)
                        .padding([.leading, .trailing, .top])
                    
                    if let ingredients = cocktail.ingredients {
                        ForEach(ingredients, id: \.self) { ingredient in
                            HStack {
                                Image(systemName: "arrowtriangle.right.fill")
                                Text(ingredient)
                            }
                            .padding([.leading, .trailing, .bottom], 5)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle(cocktail.name ?? "")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text(cocktailTitle)
                }
                .foregroundColor(.black)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
