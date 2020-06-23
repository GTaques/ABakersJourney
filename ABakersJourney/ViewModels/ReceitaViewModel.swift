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
    @Published var receita: Recipe {
        didSet {
            receita.calculatePercentages(criterion: self.receita.criterion)
        }
    }
    
    init() {
        self.receita = Recipe(title: "", description: "", category: .bread, totalAmountOfFlour: "", criterion: .grams, scope: .new, ingredients: [
            Ingredient(category: .Dough, name: "Farinha Branca", amount: "", percentage: "", isFarinha: true),
            Ingredient(category: .Dough, name: "Água", amount: "", percentage: "", isFarinha: false),
            Ingredient(category: .Dough, name: "Levain", amount: "", percentage: "", isFarinha: false),
            Ingredient(category: .Dough, name: "Salt", amount: "", percentage: "", isFarinha: false),
        ])
    }
}


struct ReceitaViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
