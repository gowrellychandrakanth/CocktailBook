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
