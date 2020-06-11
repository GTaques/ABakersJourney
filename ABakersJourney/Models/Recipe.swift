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

class Recipe: Identifiable {
    
    var id = UUID()
    var title: String
    var description: String
    var category: RecipeCategory = .bread
    var coverImage: UIImage = UIImage()
    
    var flour: Ingredient 
    var water: Ingredient 
    var salt: Ingredient
    var levain: Ingredient
    var ingredients: [Ingredient]
    var totalAmountOfFlour: Double = 0
    var criterion: Criteria = .grams
    var imageName: String
    var scope: Scope = .new
    
    
    init(title: String = "", description: String = "", flour: Ingredient, water: Ingredient, salt: Ingredient, levain: Ingredient, ingredients: [Ingredient] = [
            Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: "", isFarinha: true),
            Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""),
            Ingredient(category: .Dough, name: "Levain", amount: "", percentage: ""),
            Ingredient(category: .Dough, name: "Sal", amount: "", percentage: "")
        ], imageName: String = "") {
        self.title = title
        self.description = description
        self.flour = flour
        self.water = water
        self.salt = salt
        self.levain = levain
        self.ingredients = ingredients
        self.imageName = imageName
    }
    
    func calculatePercentages(criterion: Criteria) {
        self.totalAmountOfFlour = 0
        for ing in ingredients.filter({$0.isFarinha == true}) {
            if !ing.amount.isEmpty {
                self.totalAmountOfFlour += Double(ing.amount)!
            }
        }
        switch criterion {
        case .grams:
            // CHECK-LATER: Used filter before but I couldn't seem to find a fix for when the value is empty. Summary would not update
            // for ing in ingredients.filter({!$0.amount.isEmpty}) {}
            for ing in ingredients {
                if ing.amount.isEmpty {
                    ing.percentage = ""
                } else {
                    ing.percentage = String(format: "%.1f", Double(ing.amount)! * 100 / self.totalAmountOfFlour)
                }
            }
            break
        case .percentage:
            for ing in ingredients {
                if ing.percentage.isEmpty {
                    ing.amount = ""
                } else {
                    ing.amount = String(format: "%.0f", Double(ing.percentage)! * self.totalAmountOfFlour / 100)
                }
            }
            break
        }
    }
    
    //This should go to a service layer
    
}
