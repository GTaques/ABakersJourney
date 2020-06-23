//
//  IngredientService.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 23/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation
import CloudKit

class IngredientService {
    
    static func bulkSave(items: [Ingredient], parentEntity: Recipe?, completion: @escaping (Result<[Ingredient], Error>) -> ()) {
        var ingredientsToSave: [CKRecord] = []
        for ing in items {
            let record = ing.parseToRecord(entity: ing)
            if let id = parentEntity?.recordId {
                record["receita"] = CKRecord.Reference(recordID: id, action: .none)
            }
            ingredientsToSave.append(record)
        }
        
        let operation = CKModifyRecordsOperation(recordsToSave: ingredientsToSave)
        operation.isAtomic = true
        operation.perRecordCompletionBlock = { (result,err)  in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
                completion(.success(items))
            }
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    }
}
