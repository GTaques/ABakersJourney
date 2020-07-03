//
//  ReceitaViewModel.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 01/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI
import Combine
import CoreData

class MockRecipe {
    var title: String
    var description: String
    var image: UIImage
    var totalAmountOfFlour: String
    var criterion: Criteria
    var ingredients: [MockIngredient]
    
    init(title: String, description: String, image: UIImage, totalAmountOfFlour: String, criterion: Criteria, ingredients: [MockIngredient]) {
        self.title = title
        self.description = description
        self.image = image
        self.totalAmountOfFlour = totalAmountOfFlour
        self.criterion = criterion
        self.ingredients = ingredients
    }
    
    func calculatePercentages(criterion: Criteria) {
                if !self.totalAmountOfFlour.isEmpty {
                    switch criterion {
                    case .grams:
                        // CHECK-LATER: Used filter before but I couldn't seem to find a fix for when the value is empty. Summary would not update
                        // for ing in ingredients.filter({!$0.amount.isEmpty}) {}
                        for ing in self.ingredients {
                            if ing.amount.isEmpty {
                                ing.percentage = ""
                            } else {
                                ing.percentage = String(format: "%.1f", Double(ing.amount)! * 100 / Double(self.totalAmountOfFlour)!)
                            }
                        }
                        break
                    case .percentage:
                        for ing in self.ingredients {
                            if ing.percentage.isEmpty {
                                ing.amount = ""
                            } else {
                                ing.amount = String(format: "%.0f", Double(ing.percentage)! * Double(self.totalAmountOfFlour)! / 100)
                            }
                        }
                        break
                    }
                        
                   
                }
            }
}

class MockIngredient {
    
    var name: String
    var amount: String
    var percentage: String
    var isFarinha: Bool
    
    init(name: String, amount: String, percentage: String, isFarinha: Bool) {
        self.name = name
        self.amount = amount
        self.percentage = percentage
        self.isFarinha = isFarinha
    }
}


class ReceitaViewModel: ObservableObject {
    
    
    @Published var receita: MockRecipe = MockRecipe(title: "", description: "", image: UIImage(), totalAmountOfFlour: "", criterion: .grams, ingredients: [
        MockIngredient(name: "Farinha", amount: "", percentage: "", isFarinha: true),
        MockIngredient(name: "Água", amount: "", percentage: "", isFarinha: false),
        MockIngredient(name: "Sal", amount: "", percentage: "", isFarinha: false),
        MockIngredient(name: "Levain", amount: "", percentage: "", isFarinha: false)
    ]) {
        didSet {
            receita.calculatePercentages(criterion: self.receita.criterion)
        }
    }
    
    init() {
        //        self.receita = Recipe(title: "", description: "", category: .bread, totalAmountOfFlour: "", criterion: .grams, scope: .new, ingredients: [
        //            Ingredient(category: .Dough, name: "Farinha Branca", amount: "", percentage: "", isFarinha: true),
        //            Ingredient(category: .Dough, name: "Água", amount: "", percentage: "", isFarinha: false),
        //            Ingredient(category: .Dough, name: "Levain", amount: "", percentage: "", isFarinha: false),
        //            Ingredient(category: .Dough, name: "Salt", amount: "", percentage: "", isFarinha: false),
        //        ])
    }
}


struct ReceitaViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
