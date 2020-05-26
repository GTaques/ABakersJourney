//
//  RecipeSummaryView.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 24/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI

struct RecipeSummaryView: View {
    
    @Binding var ingredients: [Ingredient]
    
    var body: some View {
        List(ingredients, id: \.id) { ingredient in
            HStack {
                Text(ingredient.amount.isEmpty ? "" : ingredient.name)
                Text(ingredient.amount.isEmpty ? "" : "\(ingredient.amount)g")
                Spacer()
                Text(ingredient.amount.isEmpty ? "" : "100%")
            }
            
        }
        
    }
}


struct RecipeSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
