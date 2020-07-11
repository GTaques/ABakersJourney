//
//  Recipe+CoreDataClass.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 27/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Recipe)
public class Recipe: NSManagedObject {
    
    var criterion: Criteria = .grams
    var mockIngredients: [Ingredient] = []
    
    func calculatePercentages(criterion: Criteria) {
        if !self.wrappedTotalAmountOfFlour.isEmpty {
            switch self.criterion {
            case .grams:
                // CHECK-LATER: Used filter before but I couldn't seem to find a fix for when the value is empty. Summary would not update
                // for ing in ingredients.filter({!$0.amount.isEmpty}) {}
                for ing in self.mockIngredients {
                    if ing.wrappedAmount.isEmpty {
                        ing.percentage = ""
                    } else {
                        ing.percentage = String(format: "%.1f", Double(ing.amount!)! * 100 / Double(self.totalAmountOfFlour!)!)
                    }
                }
                break
            case .percentage:
                for ing in self.mockIngredients {
                    if ing.wrappedPercentage.isEmpty {
                        ing.amount = ""
                    } else {
                        ing.amount = String(format: "%.0f", Double(ing.wrappedPercentage)! * Double(self.wrappedTotalAmountOfFlour)! / 100)
                    }
                }
                break
            default:
                break
            }
            
            
        }
    }
}
