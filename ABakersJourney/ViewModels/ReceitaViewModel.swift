//
//  ReceitaViewModel.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 01/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI
import Combine

class ReceitaViewModel: ObservableObject {
    @Published var receita: Recipe = Recipe(title: "", description: "", flour: Ingredient(), water: Ingredient(), salt: Ingredient(), levain: Ingredient(), ingredients: [
            Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: "", isFarinha: true),
            Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""),
            Ingredient(category: .Dough, name: "Levain", amount: "", percentage: ""),
            Ingredient(category: .Dough, name: "Sal", amount: "", percentage: "")
    ]) {
        didSet {
            receita.calculatePercentages()
            for ing in receita.ingredients {
                print(ing.amount)
            }
        }
    }
}


struct ReceitaViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
