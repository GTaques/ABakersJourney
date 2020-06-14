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
    
    struct RecordType {
        static let Recipe = "Recipe"
    }
    
    enum CloudKitErrorHelper: Error {
        case recordFailure
        case recordIDFailure
        case castFailure
        case cursorFailure
    }
    
    static func save(item: Recipe, completion: @escaping (Result<Recipe, Error>) -> ()) {
        let itemRecord = CKRecord(recordType: RecordType.Recipe)
        itemRecord["title"] = item.title as CKRecordValue
        itemRecord["description"] = item.description as CKRecordValue
        
        CKContainer.default().publicCloudDatabase.save(itemRecord) { record, error in
            DispatchQueue.main.async {
                if let err = error {
                    completion(.failure(err))
                    return
                }
                guard let record = record else {
                    completion(.failure(CloudKitErrorHelper.recordFailure))
                    return
                }
                guard let title = record["title"] as? String, let description = record["description"] as? String else {
                    completion(.failure(CloudKitErrorHelper.castFailure))
                    return
                }
                let element = Recipe(title: title, description: description ,category: .bread, totalAmoountOfFlour: 0, criterion: .grams, scope: .new)
                completion(.success(element))
            }
        }
    }
    
    static func fetch(completion: @escaping (Result<Recipe, Error>) -> ()) {
        let pred = NSPredicate(value: true)
//        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: RecordType.Recipe, predicate: pred)
//        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["title"]
        operation.resultsLimit = 50
        
        operation.recordFetchedBlock = { record in
            DispatchQueue.main.async {
                let recordID = record.recordID
                guard let title = record["title"] as? String else { return }
                let recipe = Recipe(title: title, description: "", category: .bread, totalAmoountOfFlour: 0, criterion: .grams, scope: .new)
                completion(.success(recipe))
            }
        }
        
        operation.queryCompletionBlock = { (/*cursor*/ _, err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
                //                guard let cursor = cursor else {
                //                    completion(.failure(CloudKitHelperError.cursorFailure))
                //                    return
                //                }
                //                print("Cursor: \(String(describing: cursor))")
            }
            
        }
        
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    static func delete(recordID: CKRecord.ID, completion: @escaping (Result<CKRecord.ID, Error>) -> ()) {
        CKContainer.default().publicCloudDatabase.delete(withRecordID: recordID) { (recordID, err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
                guard let recordID = recordID else {
                    completion(.failure(CloudKitErrorHelper.recordIDFailure))
                    return
                }
                completion(.success(recordID))
            }
        }
    }
    
    static func modify(item: Recipe, completion: @escaping (Result<Recipe, Error>) -> ()) {
        
    }
    
}
