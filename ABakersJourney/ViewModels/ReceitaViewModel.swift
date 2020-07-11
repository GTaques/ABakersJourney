//
//  ReceitaViewModel.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 01/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI
import Combine
import CoreData

class ReceitaViewModel: ObservableObject {
    
    var ingredients: [IngredientObject] = [
        IngredientObject(isFarinha: true, name: "", amount: "", percentage: "")
    ]
    
    @Published var receita: RecipeObject {
        didSet {
            receita.calculatePercentages(criterion: self.receita.criterion)
        }
    }
    
    
    init() {
        let ingredients =  [
               IngredientObject(isFarinha: true, name: "Trigo", amount: "", percentage: ""),
               IngredientObject(isFarinha: false, name: "Água", amount: "", percentage: ""),
               IngredientObject(isFarinha: false, name: "Sal", amount: "", percentage: ""),
               IngredientObject(isFarinha: false, name: "Levain", amount: "", percentage: "")
        ]
        
        self.receita = RecipeObject(title: "", description: "", totalAmountOfFlour: "", ingredients: ingredients, createdAt: Date(), criterion: .grams)
    }
}


struct ReceitaViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
