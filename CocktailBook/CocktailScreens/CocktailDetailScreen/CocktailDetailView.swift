//
//  CocktailDetailView.swift
//  CocktailBook
//
//  Created by Chandra Kanth on 08/03/25.
//

import SwiftUI

struct CocktailDetailView: View {
    let cocktailItem: CocktailModel
    let cocktailTitle: String
    
    @Binding var favouritesToggle: Bool
    let cocktailHelper: CocktailDataManager
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    if let preparationMinutes = cocktailItem.preparationMinutes {
                        HStack {
                            Image(systemName: "clock")
                            Text("\(preparationMinutes) Minutes")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding([.leading, .trailing])
                    }
                    
                    if let imageName = cocktailItem.imageName {
                        HStack {
                            Spacer()
                            
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                            Spacer()
                        }
                    }
                    
                    if let longDescription = cocktailItem.longDescription {
                        Text(longDescription)
                            .padding()
                    }
                    
                    Text("Ingredients")
                        .font(.headline)
                        .padding([.leading, .trailing, .top])
                    
                    if let ingredients = cocktailItem.ingredients {
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
        .navigationTitle(cocktailItem.name ?? "")
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
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    favouritesToggle.toggle()
                    if favouritesToggle {
                        cocktailHelper.addData(cocktailItem.id)
                    } else {
                        cocktailHelper.removeData(cocktailItem.id)
                    }
                }) {
                    Image(systemName: favouritesToggle ? "heart.fill" : "heart")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

