//
//  CreateIngredientView.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 25/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI

struct CreateIngredientView: View {
    
    @Binding var showingCreateIngredient: Bool
    @Binding var ingredients: [Ingredient]
    
    @State var isFlour: Bool = false
    @State var ingredient: Ingredient = Ingredient()
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informações Básicas")) {
                    Toggle(isOn: $isFlour) {
                        Text("É Farinha")
                    }
                    TextField("Nome", text: self.$ingredient.name)
                    TextField("Quantidade (g)", text: self.$ingredient.amount).keyboardType(.numberPad)
                    TextField("Porcentagem (%)", text: self.$ingredient.percentage).keyboardType(.numberPad)
                    Picker(selection: self.$ingredient.category, label: Text("Categoria")) {
                        ForEach(Category.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    
                }
            }
            .navigationBarTitle("Ingrediente", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.showingCreateIngredient.toggle()
            }) {
                Text("Cancel")
                }, trailing: Button(action: {
                    self.ingredients.append(self.ingredient)
                    self.showingCreateIngredient.toggle()
                }) {
                    Text("Save")
            })
        }
    }
}

struct CreateIngredientView_Previews: PreviewProvider {
    
    @State static var showingView: Bool = false
    @State static var ingredients: [Ingredient] = []
    
    static var previews: some View {
        CreateIngredientView(showingCreateIngredient: $showingView, ingredients: $ingredients)
    }
}
