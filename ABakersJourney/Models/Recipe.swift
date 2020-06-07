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
    var coverImage: UIImage = UIImage()
    
    var flour: Ingredient 
    var water: Ingredient 
    var salt: Ingredient
    var levain: Ingredient
    var ingredients: [Ingredient]
    var totalAmountOfFlour: Double = 0
    var criterion: Criteria = .grams
    
    init(title: String = "", description: String = "", flour: Ingredient, water: Ingredient, salt: Ingredient, levain: Ingredient, ingredients: [Ingredient] = [
            Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: "", isFarinha: true),
            Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""),
            Ingredient(category: .Dough, name: "Levain", amount: "", percentage: ""),
            Ingredient(category: .Dough, name: "Sal", amount: "", percentage: "")
    ]) {
        self.title = title
        self.description = description
        self.flour = flour
        self.water = water
        self.salt = salt
        self.levain = levain
        self.ingredients = ingredients
    }
    
    func calculatePercentages(criterion: Criteria) {
        self.totalAmountOfFlour = 0
        for ing in ingredients.filter({$0.isFarinha == true}) {
            if !ing.amount.isEmpty {
                self.totalAmountOfFlour += Double(ing.amount)!
            }
        }
        for ing in ingredients.filter({!$0.amount.isEmpty || !$0.percentage.isEmpty}) {
            switch criterion {
            case .grams:
//                for ing in ingredients.filter({!$0.amount.isEmpty}) {
                    ing.percentage = String(format: "%.1f", Double(ing.amount)! * 100 / self.totalAmountOfFlour)
//                }
            case .percentage:
//                for ing in ingredients.filter({!$0.percentage.isEmpty}) {
                    ing.amount = String(format: "%.0f", Double(ing.percentage)! * self.totalAmountOfFlour / 100)
                    print("Quantidade de \(ing.name):  \(ing.amount)")
                    print("Porcentagem de \(ing.name):  \(ing.percentage)")

//                }
            }
//            if !ing.percentage.isEmpty  {
//                ing.amount = String(format: "%.0f", Double(ing.percentage)! * self.totalAmountOfFlour / 100)
//            } else {
//                ing.percentage = String(format: "%.1f", Double(ing.amount)! * 100 / self.totalAmountOfFlour)
//            }
        }
        
        

        
        
    }
    
}
