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
    
    var body: some View {
        ZStack {

            Image("GRID")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                .overlay(Rectangle().cornerRadius(20).opacity(0.5))
//                .clipped()
                
            
            
            VStack {
                Text(recipe.title)
                .font(Font.title)
                    .fontWeight(.medium)
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
    
    @State static var recipe: Recipe = Recipe(title: "", description: "", flour: Ingredient(category: .Dough, name: "", amount: "", percentage: ""), water: Ingredient(category: .Dough, name: "", amount: "", percentage: ""), salt: Ingredient(category: .Dough, name: "", amount: "", percentage: ""), levain: Ingredient(category: .Dough, name: "", amount: "", percentage: ""), ingredients: [Ingredient()])
    
    static var previews: some View {
        RecipeCardView(recipe: $recipe)
    }
}
