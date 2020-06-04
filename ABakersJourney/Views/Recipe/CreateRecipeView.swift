//
//  CreateRecipeView.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 18/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI

struct CreateRecipeView: View {
    
    @State var receita: Recipe = Recipe(flour: Ingredient(), water: Ingredient(), salt: Ingredient(), levain: Ingredient(), ingredients: [Ingredient()])
    
    @State var ingredients: [Ingredient] = [Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: "", isFarinha: true), Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""), Ingredient(category: .Dough, name: "Levain", amount: "", percentage: ""), Ingredient(category: .Dough, name: "Sal", amount: "", percentage: "")
        ]
    @State var showingCreateIngredient: Bool = false
    
    @ObservedObject var receitaViewModel: ReceitaViewModel = ReceitaViewModel()
    
    
    var steps: [String] = ["Ativar Fermento", "Autólise", "Adicionar Levain", "Adicionar Sal", "Laminação", "Dobra #1", "Dobra #2", "Dobra #3", "Modelagem"]
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    RecipeSummaryView(receitaViewModel: self.receitaViewModel).frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                    Form {
                        Section(header: Text("Informações Básicas")) {
                            TextField("Nome", text: self.$receita.title)
                            TextField("Descrição", text: self.$receita.description)
                        }
                        Section(header: Text("Ingredientes")) {
                            Picker("", selection: self.$receitaViewModel.receita.criterion) {
                                ForEach(Criterion.allCases, id: \.self) { c in
                                    Text(c.rawValue)
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                            List(self.ingredients.indices) { index in
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .foregroundColor(.red)
                                    TextField(self.receitaViewModel.receita.ingredients[index].name, text: self.$receitaViewModel.receita.ingredients[index].amount)
                                        .keyboardType(.decimalPad)
                                }
                            }
                            Button(action: {
                                self.showingCreateIngredient.toggle()
                            }) {
                                Text("Adicionar")
                            }
                            .sheet(isPresented: self.$showingCreateIngredient) {
                                CreateIngredientView(showingCreateIngredient: self.$showingCreateIngredient, ingredients: self.$ingredients)
                            }
                        }
                        Section(header: Text("Etapas")) {
                            List(self.steps, id: \.self) { step in
                                HStack {
                                    Image(systemName: "1.circle.fill")
                                    Text(step)
                                }
                            }
                        }
                    }.frame(width: geometry.size.width, height: geometry.size.height * 0.7)
                } // end
            }
            .navigationBarTitle("Criar Receita")
            .navigationBarItems(trailing: Button(action: {
                print("Saved!")
            }) { Text("Save")
            })
            .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        }
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView()
    }
}
