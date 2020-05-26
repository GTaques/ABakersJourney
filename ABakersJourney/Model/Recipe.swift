//
//  Recipe.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 19/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation
import Combine
import UIKit

class Recipe: Identifiable {
    
    var id = UUID()
    var title: String
    var description: String
    var coverImage: UIImage = UIImage()
    
    var flour: Ingredient
    var water: Ingredient 
    var salt: Ingredient
    var levain: Ingredient
    
    init(title: String = "", description: String = "", flour: Ingredient, water: Ingredient, salt: Ingredient, levain: Ingredient) {
        self.title = title
        self.description = description
        self.flour = flour
        self.water = water
        self.salt = salt
        self.levain = levain
    }
    
}
