//
//  RecipeCardView.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 18/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI

struct RecipeCardView: View {
    
    @Binding var recipe: Recipe
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack {

            Image(recipe.imageName ?? "pao1")
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .overlay(Rectangle().cornerRadius(8).foregroundColor(.black).opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                
            VStack(alignment: .leading) {
                Text(recipe.title)
                .font(Font.title)
                    .fontWeight(.medium).foregroundColor(.white)
                HStack {
                    HStack {
                        Image(systemName: "timer")
                        Text("~26h")
                    }
                    
                }
            }
            .foregroundColor(.white)
        }
       
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    
    @State static var recipe: Recipe = Recipe(title: "", description: "", category: .bread, totalAmountOfFlour: "", criterion: .grams, scope: .new, ingredients: [])
    @State static var width: CGFloat = 40
    @State static var height: CGFloat = 60
    
    
    static var previews: some View {
        RecipeCardView(recipe: $recipe, width: width, height: height)
    }
}
