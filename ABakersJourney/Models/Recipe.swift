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
import CloudKit

struct Recipe: Identifiable {
    
    static let recordType = "Recipe"
    let id = UUID()
    private var recordId: CKRecord.ID?
    var title: String
    var description: String
    var database: CKDatabase?
    var category: RecipeCategory
    var coverImage: CKAsset?
    var totalAmountOfFlour: Double
    var criterion: Criteria
    var imageName: String?
    var scope: Scope
    var auxiliarReload: Bool = false
    
//    var flour: Ingredient 
//    var water: Ingredient 
//    var salt: Ingredient
//    var levain: Ingredient
    var ingredients: [Ingredient] = []
    
    
    init(title: String, description: String, category: RecipeCategory, totalAmoountOfFlour: Double, criterion: Criteria, scope: Scope, ingredients: [Ingredient] = [Ingredient(category: .Dough, name: "", amount: "", percentage: "", isFarinha: true)]) {
        self.title = title
        self.description = description
        self.category = category
        self.totalAmountOfFlour = totalAmoountOfFlour
        self.criterion = criterion
        self.scope = scope
        self.ingredients = ingredients
    }
    
    init?(record: CKRecord, database: CKDatabase) {
        guard let title = record["title"] as? String else { return nil }
        guard let description = record["description"] as? String else { return nil }
        
        recordId = record.recordID
        self.title = title
        self.description = description
        self.database = database
        if let categoryValue = record["category"] as? Int,
            let category = RecipeCategory(rawValue: categoryValue) {
            self.category = category
        } else {
            self.category = .none
        }
        self.coverImage = record["coverImage"] as? CKAsset
        if let totalAmountOfFlour = record["totalAmountOfFlour"] as? Double {
            self.totalAmountOfFlour = totalAmountOfFlour
        } else {
            self.totalAmountOfFlour = 0
        }
        if let criterionValue = record["criterion"] as? String,
            let criterion = Criteria(rawValue: criterionValue) {
            self.criterion = criterion
        } else {
            self.criterion = .none
        }
        self.imageName = record["imageName"]
        if let scopeValue = record["scope"] as? Int,
            let scope = Scope(rawValue: scopeValue) {
            self.scope = scope
        } else {
            self.scope = .new
        }
        
        
    }
    
    mutating func calculatePercentages(criterion: Criteria) {
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
        default:
            break
        }
    }
    
    //This should go to a service layer
    
}
