//
//  Ingredient.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 19/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation

enum Category: String, CaseIterable {
    case Dough
    case Levain
    case Starter
}

class Ingredient: Identifiable {
    
    var id = UUID()
    
    var category: Category
    var name: String
    var amount: String
    var percentage: String
    
    init(category: Category = .Dough, name: String = "", amount: String = "", percentage: String = "") {
        self.category = category
        self.name = name
        self.amount = amount
        self.percentage = percentage
    }
}
