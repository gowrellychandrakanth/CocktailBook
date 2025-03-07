//
//  CocktailListItemView.swift
//  CocktailBook
//
//  Created by Chandra Kanth on 07/03/25.
//

import SwiftUI

struct CocktailListItemView: View {
    let cocktail: CocktailModel
    
    var body: some View {
        HStack {
            if let imageName = cocktail.imageName {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            }
            
            VStack(alignment: .leading) {
                if let name = cocktail.name {
                    Text(name)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                if let shortDescription = cocktail.shortDescription {
                    Text(shortDescription)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
    }
}
