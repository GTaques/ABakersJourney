//
//  Storable.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 16/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation
import CloudKit

protocol Storable {
    var recordType: String { get set }
    func parseToRecord<T:Storable>(entity: T) -> CKRecord
    func parseToEntity<T:CKRecord>(record: T) -> Storable
    func retrieveDesiredKeys(recordType: String) -> [String]
}
