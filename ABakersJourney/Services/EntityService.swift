//
//  EntityService.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 16/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation
import CloudKit

struct EntityService: PCloudKitService {
    
    static func save<T>(item: T, completion: @escaping (Result<T, Error>) -> ()) where T : Storable {
        let itemRecord = item.parseToRecord(entity: item)
        CKContainer.default().publicCloudDatabase.save(itemRecord) { record, error in
            DispatchQueue.main.async {
                if let err = error {
                    completion(.failure(err))
                    return
                }
                guard record != nil else {
                    completion(.failure(CloudKitErrorHelper.recordFailure))
                    return
                }
//                let id = record?.recordID
                let test = item.parseToEntity(record: record!) as! T
                let element: Result<T, Error> = .success(test)
//                CKModifyRecordsOperation(recordsToSave:, recordIDsToDelete: <#T##[CKRecord.ID]?#>)
//                print(record?.recordID)
                completion(element)
            }
        }
    }
    
    static func fetch<T>(entity: T, completion: @escaping (Result<Storable, Error>) -> ()) where T : Storable {
        let pred = NSPredicate(value: true)
        //        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: entity.recordType, predicate: pred)
        //        query.sortDescriptors = [sort]
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = entity.retrieveDesiredKeys(recordType: entity.recordType)
        operation.resultsLimit = 50
        
        operation.recordFetchedBlock = { record in
            DispatchQueue.main.async {
                let _ = record.recordID
                let item = entity.parseToEntity(record: record)
                
                completion(.success(item))
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
    
}
