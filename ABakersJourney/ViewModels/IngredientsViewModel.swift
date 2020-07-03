//
//  IngredientsViewModel.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 29/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation

class IngredientsViewModel: ObservableObject {
    
    @Published var ingredients: [Ingredient] = []
}
