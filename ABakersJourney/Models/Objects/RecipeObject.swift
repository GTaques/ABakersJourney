//
//  RecipeObject.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 10/07/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation
import UIKit

class RecipeObject {
    
    var title: String
    var description: String
    var image: UIImage?
    var totalAmountOfFlour: String
    var ingredients: [IngredientObject]
    var createdAt: Date
    var criterion: Criteria
    
    init(title: String, description: String, totalAmountOfFlour: String, ingredients: [IngredientObject], createdAt: Date, criterion: Criteria) {
        self.title = title
        self.description = description
        self.totalAmountOfFlour = totalAmountOfFlour
        self.ingredients = ingredients
        self.createdAt = createdAt
        self.criterion = criterion
    }
    
    func calculatePercentages(criterion: Criteria) {
        if !self.totalAmountOfFlour.isEmpty {
            switch self.criterion {
            case .grams:
                // CHECK-LATER: Used filter before but I couldn't seem to find a fix for when the value is empty. Summary would not update
                // for ing in ingredients.filter({!$0.amount.isEmpty}) {}
                for ing in self.ingredients {
                    if ing.amount.isEmpty {
                        ing.percentage = ""
                    } else {
                        ing.percentage = String(format: "%.1f", Double(ing.amount)! * 100 / Double(self.totalAmountOfFlour)!)
                    }
                }
                break
            case .percentage:
                for ing in self.ingredients {
                    if ing.percentage.isEmpty {
                        ing.amount = ""
                    } else {
                        ing.amount = String(format: "%.0f", Double(ing.percentage)! * Double(self.totalAmountOfFlour)! / 100)
                    }
                }
                break
            default:
                break
            }
            
            
        }
    }
}
