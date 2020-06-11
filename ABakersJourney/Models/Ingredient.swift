//
//  Ingredient.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 19/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation

enum IngredientCategory: String, CaseIterable {
    case Dough
    case Levain
    case Starter
}

class Ingredient: Identifiable {
    
    var id = UUID()
    
    var category: IngredientCategory
    var name: String
    var amount: String
    var percentage: String
    var isFarinha: Bool
    
    init(category: IngredientCategory = .Dough, name: String = "", amount: String = "", percentage: String = "", isFarinha: Bool = false) {
        self.category = category
        self.name = name
        self.amount = amount
        self.percentage = percentage
        self.isFarinha = isFarinha
    }
}
