//
//  ReceitasViewModel.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 08/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI
import Combine
import CoreData

class ReceitasViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    
//    init() {
//        CoreDataService.shared.get(predicate: nil, completion: { recipes in
//            self.recipes = recipes
//        })
//    }
    
}

