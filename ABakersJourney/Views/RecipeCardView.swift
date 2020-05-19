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
            Rectangle()
                .foregroundColor(.green)
                .cornerRadius(20)
            VStack {
                Text(recipe.title)
                .font(Font.title)
                HStack {
                    HStack {
                        Image(systemName: "timer")
                        Text("~26h")
                    }
                    
                }
            }
            
        }
       
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    
    @State static var recipe: Recipe = Recipe(title: "", description: "", flour: Ingredient(category: .Dough, name: "", amount: 10, percentage: 10), water: Ingredient(category: .Dough, name: "", amount: 10, percentage: 10), salt: Ingredient(category: .Dough, name: "", amount: 10, percentage: 10), levain: Ingredient(category: .Dough, name: "", amount: 10, percentage: 10))
    
    static var previews: some View {
        RecipeCardView(recipe: $recipe)
    }
}
