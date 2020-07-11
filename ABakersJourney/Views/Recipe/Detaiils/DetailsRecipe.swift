//
//  DetailsRecipe.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 09/07/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI

struct DetailsRecipe: View {
    
    var recipe: Recipe
    
    var body: some View {
//        NavigationView {
            List {
                ForEach(recipe.ingredientArray, id: \.self) { ingredient in
                    Text(ingredient.wrappedName)
                }
            }.navigationBarTitle(Text("\(recipe.title ?? "No title")"))
//        }
        
    }
}

struct DetailsRecipe_Previews: PreviewProvider {
    
    @State static var receitaVM = Recipe()
    
    static var previews: some View {
        DetailsRecipe(recipe: receitaVM)
    }
}
