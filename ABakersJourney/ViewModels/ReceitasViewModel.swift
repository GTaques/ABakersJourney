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
//    let container: CKContainer
//    let publicDB: CKDatabase
//    let privateDB: CKDatabase
    
    @Published var receitas: [Recipe] {
        didSet {
            print("Loaded Recipes")
        }
    }
    
    init() {
        self.receitas = [
            Recipe(title: "Tartine Country Bread", description: "Bem gostoso", flour: Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: "100"), water: Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""), salt: Ingredient(category: .Dough, name: "Sal", amount: "", percentage: ""), levain: Ingredient(category: .Levain, name: "Levain", amount: "", percentage: ""), ingredients: [Ingredient()], imageName: "pao1"),
            Recipe(title: "Foccacia", description: "Bem gostoso", flour: Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: ""), water: Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""), salt: Ingredient(category: .Dough, name: "Sal", amount: "", percentage: ""), levain: Ingredient(category: .Levain, name: "Levain", amount: "", percentage: ""), ingredients: [Ingredient()], imageName: "pao2"),
            Recipe(title: "Foccacia", description: "Bem gostoso", flour: Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: ""), water: Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""), salt: Ingredient(category: .Dough, name: "Sal", amount: "", percentage: ""), levain: Ingredient(category: .Levain, name: "Levain", amount: "", percentage: ""), ingredients: [Ingredient()], imageName: "pao3"),
            Recipe(title: "Foccacia", description: "Bem gostoso", flour: Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: ""), water: Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""), salt: Ingredient(category: .Dough, name: "Sal", amount: "", percentage: ""), levain: Ingredient(category: .Levain, name: "Levain", amount: "", percentage: ""), ingredients: [Ingredient()], imageName: "pao4")
            
        ]
    }
    
    @objc
    func refresh(_ completion: @escaping (Error?) -> Void) {
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Recipe", predicate: predicate)
        
    }
    
    private func recipes(forQuery query: CKQuery, _ completion: @escaping (Error?) -> Void) {
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
//                Receita()
//            }
//        }
    }
}
