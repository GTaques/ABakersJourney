//
//  Recipe.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 19/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation
import Combine
import UIKit

enum Criterion: String, CaseIterable {
    case grams = "g"
    case percentage = "%"
}

class Recipe: Identifiable {
    
    var id = UUID()
    var title: String
    var description: String
    var coverImage: UIImage = UIImage()
    
    var flour: Ingredient 
    var water: Ingredient 
    var salt: Ingredient
    var levain: Ingredient
    var ingredients: [Ingredient]
    var totalAmountOfFlour: Double = 0
    var criterion: Criterion = .grams
    
    init(title: String = "", description: String = "", flour: Ingredient, water: Ingredient, salt: Ingredient, levain: Ingredient, ingredients: [Ingredient] = [Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: "", isFarinha: true), Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""), Ingredient(category: .Dough, name: "Levain", amount: "", percentage: ""), Ingredient(category: .Dough, name: "Sal", amount: "", percentage: "")
    ]) {
        self.title = title
        self.description = description
        self.flour = flour
        self.water = water
        self.salt = salt
        self.levain = levain
        self.ingredients = ingredients
    }
    
    func calculatePercentages() {
        self.totalAmountOfFlour = 0
        for ing in ingredients.filter({$0.isFarinha == true}) {
            self.totalAmountOfFlour += Double(ing.amount)!
            print(self.totalAmountOfFlour)
        }
        for ing in ingredients.filter({!$0.amount.isEmpty}) {
            ing.percentage = String(format: "%.1f", Double(ing.amount)! * 100 / self.totalAmountOfFlour)
        }
        //self.totalAmountOfFlour == 100%
        //self.water.amount == x
        
    }
    
}
