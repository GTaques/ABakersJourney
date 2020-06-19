//
//  PCloudKitService.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 15/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation
import CloudKit

struct RecordType {
    static let Recipe = "Recipe"
    static let Ingredient = "Ingredient"
}

enum CloudKitErrorHelper: Error {
    case recordFailure
    case recordIDFailure
    case castFailure
    case cursorFailure
}

protocol PCloudKitService {
    static func save<T:Storable>(item: T, completion: @escaping (Result<T, Error>) -> ())
    static func fetch<T:Storable>(entity: T, completion: @escaping (Result<Storable, Error>) -> ())
//    static func delete<T>(recordID: T, completion: @escaping (Result<T, Error>) -> ())
//    static func modify<T>(item: T, completion: @escaping (Result<T, Error>) -> ())
}
