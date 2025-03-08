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
    let cocktailDataHelper: CocktailDataManager
    
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
                        cocktailDataHelper.addData(cocktailItem.id)
                    } else {
                        cocktailDataHelper.removeData(cocktailItem.id)
                    }
                }) {
                    Image(systemName: favouritesToggle ? "heart.fill" : "heart")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    CocktailDetailView(
        cocktailItem: CocktailModel(
            id: "1",
            name: "Mojito",
            type: "alcoholic",
            shortDescription: "A refreshing Cuban classic made with white rum and muddled fresh mint.",
            longDescription: "This is an authentic recipe for mojito. I sized the recipe for one serving, but you can adjust it accordingly and make a pitcher full. It's a very refreshing drink for hot summer days. Be careful when drinking it, however. If you make a pitcher you might be tempted to drink the whole thing yourself, and you just might find yourself talking Spanish in no time! Tonic water can be substituted instead of the soda water but the taste is different and somewhat bitter.",
            preparationMinutes: 10,
            imageName: "mojito",
            ingredients: [
                "10 fresh mint leaves",
                "½ lime, cut into 4 wedges",
                "2 tablespoons white sugar, or to taste",
                "1 cup ice cubes",
                "1 ½ fluid ounces white rum",
                "½ cup club soda"
            ],
            isFavorite: true
        ),
        cocktailTitle: "All Cocktails",
        favouritesToggle: .constant(true),
        cocktailDataHelper: CocktailDataManager()
    )
}
