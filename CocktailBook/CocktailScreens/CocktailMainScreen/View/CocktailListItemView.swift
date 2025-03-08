//
//  CocktailListItemView.swift
//  CocktailBook
//
//  Created by Chandra Kanth on 07/03/25.
//

import SwiftUI

struct CocktailListItemView: View {
    let cocktailItem: CocktailModel
    
    var body: some View {
        HStack {
            if let imageName = cocktailItem.imageName {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            }
            
            VStack(alignment: .leading) {
                if let name = cocktailItem.name {
                    Text(name)
                        .font(.headline)
                        .foregroundColor(cocktailItem.isFavourite ? .blue : .primary)
                }
                
                if let shortDescription = cocktailItem.shortDescription {
                    Text(shortDescription)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            if cocktailItem.isFavourite {
                Image(systemName: "heart.fill")
                    .foregroundColor(.blue)
            }
        }
    }
}

#Preview {
    CocktailListItemView(
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
        )
    )
}
