//
//  CreateIngredientView.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 25/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI

struct CreateIngredientView: View {
    
    @ObservedObject var receitaViewModel: ReceitaViewModel
    @State var ingredient: MockIngredient = MockIngredient(name: "", amount: "", percentage: "", isFarinha: false)
    
    @Binding var ingredients: [MockIngredient]
    @Binding var showingCreateIngredient: Bool
    @Binding var criterion: Criteria
    
    var body: some View {
//        let criterion = Binding<Criteria>(get: {
////            return self.receitaViewModel.receita.criterion
//            return .grams
//        }, set: {
////            self.receitaViewModel.receita.criterion = $0
//            self.criterion = $0
//        })
        
        return NavigationView {
            Form {
                Section(header: Text("Informações Básicas")) {
                    Toggle(isOn: $ingredient.isFarinha) {
                        Text("É Farinha")
                    }
                    TextField("Nome", text: self.$ingredient.name)
                    Picker("", selection: $criterion) {
                        ForEach(Criteria.allCases, id: \.self) { c in
                            Text(c.rawValue).tag(c.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    if self.criterion == .grams {
                        TextField("Quantidade (g)", text: self.$ingredient.amount).keyboardType(.numberPad)
                    } else {
                        TextField("Porcentagem (%)", text: self.$ingredient.percentage).keyboardType(.numberPad)
                    }
                }
            }
            .navigationBarTitle("Ingrediente", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.showingCreateIngredient.toggle()
            }) {
                Text("Cancel")
                }, trailing: Button(action: {
                    self.receitaViewModel.receita.ingredients.append(self.ingredient)
                    self.showingCreateIngredient.toggle()
                }) {
                    Text("Adicionar")
            })
        }
    }
    
    func delete(at offsets: IndexSet) {
        print("delete")
    }
}

struct CreateIngredientView_Previews: PreviewProvider {
    
    @State static var showingView: Bool = false
    @State static var ingredients: [MockIngredient] = []
    @State static var ingredient: MockIngredient = MockIngredient(name: "", amount: "", percentage: "", isFarinha: true)
    @State static var receitaVM: ReceitaViewModel = ReceitaViewModel()
    @State static var criterion: Criteria = .grams
    
    static var previews: some View {
        CreateIngredientView(receitaViewModel: receitaVM, ingredient: ingredient, ingredients: $ingredients, showingCreateIngredient: $showingView, criterion: $criterion)
    }
}
