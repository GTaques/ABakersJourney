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
    
    @Binding var criterion: Criteria
    @State var showingCreateIngredient: Bool = false
    
    var body: some View {
        let criterion = Binding<Criteria>(get: {
            return self.receitaViewModel.receita.criterion
            
        }, set: {
            self.receitaViewModel.receita.criterion = $0
            self.criterion = $0
        })
        
        return Section(header: Text("Ingredients")) {
            TextField("Total de Farinha", text: $receitaViewModel.receita.totalAmountOfFlour).keyboardType(.decimalPad)
            Picker("", selection: criterion) {
                ForEach(Criteria.allCases, id: \.self) { c in
                    Text(c.rawValue).tag(c.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            if self.receitaViewModel.receita.criterion == .grams {
                List {
                    ForEach(0..<self.receitaViewModel.receita.ingredients.indices.last! + 1, id: \.self) { i in
                        TextField(self.receitaViewModel.receita.ingredients[i].name, text: self.$receitaViewModel.receita.ingredients[i].amount).keyboardType(.decimalPad)
                    }
                }
            } else {
                List {
                    ForEach(0..<self.receitaViewModel.receita.ingredients.indices.last! + 1, id: \.self) { i in
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
    @State static var criterion: Criteria = .grams
    
    static var previews: some View {
        RecipeIngredientsFormView(receitaViewModel: receitaVM, criterion: $criterion)
    }
}
