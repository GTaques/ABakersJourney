//
//  CloudKitHelper.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 13/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation
import CloudKit

struct CloudKitHelper {
    
    struct recordType {
        static let Recipe = "Recipe"
    }
    
    enum CloudKitErrorHelper: Error {
        case recordFailure
        case recordIDFailure
        case castFailure
        case cursorFailure
    }
    
    static func save(item: Recipe, completion: @escaping (Result<Recipe, Error>) -> ()) {
        let itemRecord = CKRecord(recordType: recordType.Recipe)
        itemRecord["title"] = item.title as CKRecordValue
        itemRecord["description"] = item.description as CKRecordValue
//        itemRecord["category"] = item.category as? CKRecordValue
//        itemRecord["totalAmountOfFlour"] = item.totalAmountOfFlour as? CKRecordValue
//        itemRecord["description"] = item.description as CKRecordValue
        
        CKContainer.default().publicCloudDatabase.save(itemRecord) { record, error in
            if let err = error {
                completion(.failure(err))
                return
            }
            guard let record = record else {
                completion(.failure(CloudKitErrorHelper.recordFailure))
                return
            }
            
//            let id = record.recordID
            guard let title = record["title"] as? String, let description = record["description"] as? String else {
                completion(.failure(CloudKitErrorHelper.castFailure))
                return
            }
            let element = Recipe(title: title, description: description ,category: .bread, totalAmoountOfFlour: 0, criterion: .grams, scope: .new)
            completion(.success(element))
        }
    }
    
    static func fetch(completion: @escaping (Result<Recipe, Error>) -> ()) {
        
    }
    
    static func delete(recordID: CKRecord.ID, completion: @escaping (Result<Recipe, Error>) -> ()) {
        
    }
    
    static func modify(item: Recipe, completion: @escaping (Result<Recipe, Error>) -> ()) {}
    
}
