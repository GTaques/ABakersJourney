//
//  Recipe+CoreDataProperties.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 27/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//
//

import Foundation
import CoreData


extension Recipe {

//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
//        return NSFetchRequest<Recipe>(entityName: "Recipe")
//    }

    @NSManaged public var title: String
    @NSManaged public var description_: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var totalAmountOfFlour: String?
    @NSManaged public var ingredient: NSSet?
    
    public var wrappedTitle: String {
        title ?? "No Title"
    }
    
    public var wrappedDescription: String {
        description_ ?? "No Description"
    }
    
    public var wrappedCreatedAt: Date {
        createdAt ?? Date()
    }
    
    public var wrappedTotalAmountOfFlour: String {
        totalAmountOfFlour ?? ""
    }
    
    public var ingredientArray: [Ingredient] {
        get {
            let set = ingredient as? Set<Ingredient> ?? []
            
            return set.sorted {
                $0.wrappedName < $1.wrappedName
            }
        }
    }

}

// MARK: Generated accessors for ingredient
extension Recipe {

    @objc(addIngredientObject:)
    @NSManaged public func addToIngredient(_ value: Ingredient)

    @objc(removeIngredientObject:)
    @NSManaged public func removeFromIngredient(_ value: Ingredient)

    @objc(addIngredient:)
    @NSManaged public func addToIngredient(_ values: NSSet)

    @objc(removeIngredient:)
    @NSManaged public func removeFromIngredient(_ values: NSSet)
    
    static func getAllRecipes() -> NSFetchRequest<Recipe> {
        let request: NSFetchRequest = Recipe.fetchRequest() as! NSFetchRequest<Recipe>
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }

}
