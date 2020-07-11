//
//  IngredientObject.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 10/07/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation

class IngredientObject {
    
    var isFarinha: Bool = false
    var name: String
    var amount: String
    var percentage: String
    
    init(isFarinha: Bool, name: String, amount: String, percentage: String) {
        self.isFarinha = isFarinha
        self.name = name
        self.amount = amount
        self.percentage = percentage
    }
}
