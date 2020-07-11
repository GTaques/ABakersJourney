//
//  Ingredient+CoreDataProperties.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 27/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var name: String?
    @NSManaged public var amount: String?
    @NSManaged public var percentage: String?
    @NSManaged public var isFarinha: Bool
    @NSManaged public var belongsTo: Recipe?
    @NSManaged public var imageData: NSData?
    
    public var wrappedName: String {
        name ?? "No Name"
    }
    
    public var wrappedAmount: String {
        amount ?? ""
    }
    
    public var wrappedPercentage: String {
        percentage ?? ""
    }

}
