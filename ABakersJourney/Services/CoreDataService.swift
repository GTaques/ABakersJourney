//
//  CoreDataService.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 02/07/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import CoreData
import Foundation

class CoreDataService {
    
    let recipeEntityName = "Recipe"
    let ingredientEntityName = "Ingredient"
    
    //MARK: - Singleton
    
    static let shared = CoreDataService()
    
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ABakersJourney")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    
    func save(completion: @escaping () -> Void) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data Deleting Support
    
    func flush() {
        flush(entityName: recipeEntityName)
        flush(entityName: ingredientEntityName)
    }

    func flush(entityName: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        deleteRequest.resultType = .resultTypeObjectIDs

        do {
            let result = try viewContext.execute(deleteRequest) as? NSBatchDeleteResult
            guard let objectIDs = result?.result as? [NSManagedObjectID] else {
                return
            }

            // Updates the main context
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: objectIDs], into: [self.viewContext])

        } catch {
            fatalError("Failed to execute request: \(error)")
        }
    }
    
    //MARK: - Core Data Fetching Support
    //MARK: - Entity Recipe
    
    func saveRecipe(recipe: RecipeObject, completion: @escaping () -> Void) {
        let context = persistentContainer.viewContext
        
        let managedRecipe = Recipe(context: context)
        managedRecipe.title = recipe.title
        managedRecipe.description_ = recipe.description
        managedRecipe.createdAt = Date()
        
        if context.hasChanges {
            do {
                for i in 0..<recipe.ingredients.count {
                    let managedIngredient = Ingredient(context: context)
                    managedIngredient.name = recipe.ingredients[i].name
                    managedIngredient.amount = recipe.ingredients[i].amount
                    managedIngredient.percentage = recipe.ingredients[i].percentage
                    managedIngredient.isFarinha = recipe.ingredients[i].isFarinha
                    managedIngredient.belongsTo = managedRecipe
                    managedRecipe.ingredients?.adding(managedIngredient)
                }
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getRecipes(predicate: NSPredicate?, completion: @escaping ([Recipe]) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: recipeEntityName)
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]

        if let predicate = predicate {
            request.predicate = predicate
        }

        // Creates `asynchronousFetchRequest` with the fetch request and the completion closure
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: request) { asynchronousFetchResult in
            guard let result = asynchronousFetchResult.finalResult as? [Recipe] else {
                completion([])
                return
            }
            completion(result)
            print(result)
        }

        do {
            try viewContext.execute(asynchronousFetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //MARK: Entity Ingredient
    func getIngredients(predicate: NSPredicate?, completion: @escaping ([Ingredient]) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ingredientEntityName)
        request.sortDescriptors = []
        
        if let predicate = predicate {
            request.predicate = predicate
        }
        
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: request) { asynchronousFetchRequest in
            guard let result = asynchronousFetchRequest.finalResult as? [Ingredient] else {
                completion([])
                return
            }
            completion(result)
        }
        
        do {
            try viewContext.execute(asynchronousFetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
