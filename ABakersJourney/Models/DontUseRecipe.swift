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

//struct Recipe: Identifiable {
//    static let recordType = "Recipe"
//    let id = UUID()
//    var recordId: CKRecord.ID?
//    var title: String
//    var description: String
//    var database: CKDatabase?
//    var category: RecipeCategory
//    var coverImage: CKAsset?
//    var totalAmountOfFlour: String
//    var criterion: Criteria
//    var imageName: String?
//    var scope: Scope
//    var ingredients: [Ingredient]
//    
//    init() {
//        self.title = ""
//        self.description = ""
//        self.category = .bread
//        self.totalAmountOfFlour = ""
//        self.criterion = .grams
//        self.scope = .new
//        self.ingredients = []
//    }
//    
//    init(recordId: CKRecord.ID = CKRecord.ID(), title: String, description: String, category: RecipeCategory, totalAmountOfFlour: String, criterion: Criteria, scope: Scope, ingredients: [Ingredient] = [
//        Ingredient(category: .Dough, name: "Farinha", amount: "0", percentage: "0", isFarinha: true),
//        Ingredient(category: .Dough, name: "Água", amount: "0", percentage: "0", isFarinha: false),
//        Ingredient(category: .Dough, name: "Levain", amount: "0", percentage: "0", isFarinha: false),
//        Ingredient(category: .Dough, name: "Salt", amount: "0", percentage: "0", isFarinha: false),
//        ]) {
//        self.recordId = recordId
//        self.title = title
//        self.description = description
//        self.category = category
//        self.totalAmountOfFlour = totalAmountOfFlour
//        self.criterion = criterion
//        self.scope = scope
//        self.ingredients = ingredients
//    }
//    
//    func calculatePercentages(criterion: Criteria) {
//        if !self.totalAmountOfFlour.isEmpty {
//            switch criterion {
//            case .grams:
//                // CHECK-LATER: Used filter before but I couldn't seem to find a fix for when the value is empty. Summary would not update
//                // for ing in ingredients.filter({!$0.amount.isEmpty}) {}
//                for ing in ingredients {
//                    if ing.amount.isEmpty {
//                        ing.percentage = ""
//                    } else {
//                        ing.percentage = String(format: "%.1f", Double(ing.amount)! * 100 / Double(self.totalAmountOfFlour)!)
//                    }
//                }
//                break
//            case .percentage:
//                for ing in ingredients {
//                    if ing.percentage.isEmpty {
//                        ing.amount = ""
//                    } else {
//                        ing.amount = String(format: "%.0f", Double(ing.percentage)! * Double(self.totalAmountOfFlour)! / 100)
//                    }
//                }
//                break
//            }
//        }
//    }
//}

//extension Recipe {
//    var recordType: String {
//        get {
//            return "Recipe"
//        }
//    }
//
//    func parseToRecord<T>(entity: T) -> CKRecord where T : Storable {
//        let record = CKRecord(recordType: RecordType.Recipe)
//        if let entity = entity as? Recipe {
//            record["title"] = entity.title
//            record["description"] = entity.description
//        }
//        return record
//    }
    
//    func parseToEntity<T>(record: T) -> Storable where T : CKRecord {
//        let recordId = record.recordID
//        let title = record["title"]
//        let description = record["title"]
        
//        return Recipe(recordId: recordId, title: title as! String, description: description as! String, category: .bread, totalAmountOfFlour: "",  criterion: .grams, scope: .new)
//        return Recipe()
//    }
//    
//    func retrieveDesiredKeys(recordType: String) -> [String] {
//        return ["title", "description"]
//        
//    }
//    
//    
//    
//}
