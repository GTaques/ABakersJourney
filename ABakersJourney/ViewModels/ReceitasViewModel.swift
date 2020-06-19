//
//  ReceitasViewModel.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 08/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI
import Combine
import CloudKit

class ReceitasViewModel: ObservableObject {
    
    // MARK: - iCloud Info
    let container: CKContainer
    let publicDB: CKDatabase
    let privateDB: CKDatabase
    var counterSet = 0
    
    @Published var receitas: [Recipe] {
        didSet {
            counterSet += 1
            print("Loaded Recipes \(counterSet) times")
        }
    }
    
    init() {
        self.receitas = []
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
        
    }
    
//    @objc
//    func refresh(_ completion: @escaping (Error?) -> Void) {
//        let predicate = NSPredicate(value: true)
//        
//        let query = CKQuery(recordType: "Recipe", predicate: predicate)
//        recipes(forQuery: query, completion)
//    }
//    
//    private func recipes(forQuery query: CKQuery, _ completion: @escaping (Error?) -> Void) {
//        publicDB.perform(query, inZoneWith: CKRecordZone.default().zoneID) { [weak self] results, error in
//            guard let self = self else { return }
//
//            if let error = error {
//                DispatchQueue.main.async {
//                    completion(error)
//                }
//                return
//            }
//
//            guard let results = results else { return }
//            self.receitas = results.compactMap {
//                Recipe(record: $0, database: self.publicDB)
//            }
//            DispatchQueue.main.async {
//                completion(nil)
//            }
//        }
//    }
}
