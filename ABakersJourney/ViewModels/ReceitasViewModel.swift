//
//  ReceitasViewModel.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 08/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI
import Combine

class ReceitasViewModel: ObservableObject {
    @Published var receitas: [Recipe] {
        didSet {
            print("Loaded Recipes")
        }
    }
    
    init() {
        self.receitas = [
            Recipe(title: "Tartine Country Bread", description: "Bem gostoso", flour: Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: "100"), water: Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""), salt: Ingredient(category: .Dough, name: "Sal", amount: "", percentage: ""), levain: Ingredient(category: .Levain, name: "Levain", amount: "", percentage: ""), ingredients: [Ingredient()], imageName: "pao1"),
            Recipe(title: "Foccacia", description: "Bem gostoso", flour: Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: ""), water: Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""), salt: Ingredient(category: .Dough, name: "Sal", amount: "", percentage: ""), levain: Ingredient(category: .Levain, name: "Levain", amount: "", percentage: ""), ingredients: [Ingredient()], imageName: "pao2"),
            Recipe(title: "Foccacia", description: "Bem gostoso", flour: Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: ""), water: Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""), salt: Ingredient(category: .Dough, name: "Sal", amount: "", percentage: ""), levain: Ingredient(category: .Levain, name: "Levain", amount: "", percentage: ""), ingredients: [Ingredient()], imageName: "pao3"),
            Recipe(title: "Foccacia", description: "Bem gostoso", flour: Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: ""), water: Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""), salt: Ingredient(category: .Dough, name: "Sal", amount: "", percentage: ""), levain: Ingredient(category: .Levain, name: "Levain", amount: "", percentage: ""), ingredients: [Ingredient()], imageName: "pao4")
            
        ]
    }
}
