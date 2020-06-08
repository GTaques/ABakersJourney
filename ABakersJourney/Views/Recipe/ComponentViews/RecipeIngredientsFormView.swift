//
//  RecipeIngredientsFormView.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 07/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI

struct RecipeIngredientsFormView: View {
    
    @ObservedObject var receitaViewModel: ReceitaViewModel
    
    @State var gramsShowing: Bool = true
    @State var showingCreateIngredient: Bool = false
    
    var body: some View {
        let criterion = Binding<Criteria>(get: {
            return self.receitaViewModel.receita.criterion
            
        }, set: {
            self.receitaViewModel.receita.criterion = $0
            self.gramsShowing.toggle()
        })
        
        return Section(header: Text("Ingredients")) {
            TextField("Farinha", text: $receitaViewModel.receita.ingredients[0].amount).keyboardType(.decimalPad)
            Picker("", selection: criterion) {
                ForEach(Criteria.allCases, id: \.self) { c in
                    Text(c.rawValue).tag(c.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            if gramsShowing {
                List {
                    ForEach(1..<self.receitaViewModel.receita.ingredients.indices.last! + 1, id: \.self) { i in
                        TextField(self.receitaViewModel.receita.ingredients[i].name, text: self.$receitaViewModel.receita.ingredients[i].amount).keyboardType(.decimalPad)
                    }
                }
            } else {
                List {
                    ForEach(1..<self.receitaViewModel.receita.ingredients.indices.last! + 1, id: \.self) { i in
                        TextField(self.receitaViewModel.receita.ingredients[i].name, text: self.$receitaViewModel.receita.ingredients[i].percentage).keyboardType(.decimalPad)
                    }
                }
            }
            
            Button(action: {
                self.showingCreateIngredient.toggle()
            }) {
                Text("Adicionar")
            }
            .sheet(isPresented: self.$showingCreateIngredient) {
                CreateIngredientView(receitaViewModel: self.receitaViewModel, showingCreateIngredient: self.$showingCreateIngredient, criterion: self.$receitaViewModel.receita.criterion)
            }
        }
    }
}

struct RecipeIngredientsFormView_Previews: PreviewProvider {
    
    @State static var receitaVM: ReceitaViewModel = ReceitaViewModel()
    
    static var previews: some View {
        RecipeIngredientsFormView(receitaViewModel: receitaVM)
    }
}
