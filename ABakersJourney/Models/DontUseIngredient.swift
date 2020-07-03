//
//  Ingredient.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 19/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation
import CloudKit

enum IngredientCategory: String, CaseIterable {
    case Dough
    case Levain
    case Starter
}

//class Ingredient: Identifiable {
//    static let recordType = "Ingredient"
//    var id = UUID()
//    
//    var category: IngredientCategory
//    var name: String
//    var amount: String
//    var percentage: String
//    var isFarinha: Bool
//    
//    init(category: IngredientCategory = .Dough, name: String = "", amount: String = "", percentage: String = "", isFarinha: Bool = false) {
//        self.category = category
//        self.name = name
//        self.amount = amount
//        self.percentage = percentage
//        self.isFarinha = isFarinha
//    }
//}

//extension Ingredient {
//    func parseToRecord<T>(entity: T) -> CKRecord where T : Storable {
//        let record = CKRecord(recordType: RecordType.Ingredient)
//        if let entity = entity as? Ingredient {
//            record["name"] = entity.name
//            record["amount"] = entity.amount
//            record["percentage"] = entity.percentage
//        }
//        return record
//    }
//
//    func parseToEntity<T>(record: T) -> Storable where T : CKRecord {
//        let recordId = record.recordID
//        let title = record["title"]
//        let description = record["title"]
                   
//        return Recipe(recordId: recordId, title: title as! String, description: description as! String, category: .bread, totalAmountOfFlour: "",  criterion: .grams, scope: .new)
//        return Recipe()
//    }
    
//    var recordType: String {
//        return "Ingredient"
//    }
//    
//    func retrieveDesiredKeys(recordType: String) -> [String] {
//        return []
//    }
//    
//    
//}
