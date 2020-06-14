//
//  CreateRecipeView.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 18/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI

struct CreateRecipeView: View {
    
//    @State var receita: Recipe = Recipe(flour: Ingredient(), water: Ingredient(), salt: Ingredient(), levain: Ingredient(), ingredients: [Ingredient()])
    
    @State var ingredients: [Ingredient] = [Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: "", isFarinha: true), Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""), Ingredient(category: .Dough, name: "Levain", amount: "", percentage: ""), Ingredient(category: .Dough, name: "Sal", amount: "", percentage: "")
        ]
    @State var showingCreateIngredient: Bool = false
    @State var isEditMode: Bool = true
    
    @ObservedObject var receitaViewModel: ReceitaViewModel = ReceitaViewModel()
    
    
    
    var steps: [String] = ["Ativar Fermento", "Autólise", "Adicionar Levain", "Adicionar Sal", "Laminação", "Dobra #1", "Dobra #2", "Dobra #3", "Modelagem"]
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    RecipeSummaryView(receitaViewModel: self.receitaViewModel).frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                    Form {
                        Section(header: Text("Informações Básicas")) {
                            TextField("Nome", text: self.$receitaViewModel.receita.title)
                            TextField("Descrição", text: self.$receitaViewModel.receita.description)
                        }
                        RecipeIngredientsFormView(receitaViewModel: self.receitaViewModel, criterion: self.$receitaViewModel.receita.criterion, showingCreateIngredient: self.showingCreateIngredient)
//                        Section(header: Text("Ingredientes")) {
//                            Picker("", selection: criterion) {
//                                ForEach(Criteria.allCases, id: \.self) { c in
//                                    Text(c.rawValue).tag(c.rawValue)
//                                }
//                            }
//                            .pickerStyle(SegmentedPickerStyle())
//                            List {
//                                ForEach(self.receitaViewModel.receita.ingredients.indices, id: \.self) { index in
//                                    HStack {
//                                        Image(systemName: "circle.fill")
//                                            .foregroundColor(.red)
//                                        TextField(self.receitaViewModel.receita.ingredients[index].name, text: self.$receitaViewModel.receita.ingredients[index].amount)
//                                            .keyboardType(.decimalPad)
//                                    }
//                                }
//                                .onDelete(perform: self.delete)
//                            }
//
//                            Button(action: {
//                                self.showingCreateIngredient.toggle()
//                            }) {
//                                Text("Adicionar")
//                            }
//                            .sheet(isPresented: self.$showingCreateIngredient) {
//                                CreateIngredientView(showingCreateIngredient: self.$showingCreateIngredient, receitaViewModel: self.receitaViewModel)
//                            }
//                        }
//                        Section(header: Text("Etapas")) {
//                            List(self.steps, id: \.self) { step in
//                                HStack {
//                                    Image(systemName: "1.circle.fill")
//                                    Text(step)
//                                }
//                            }
//                        }
                    }.frame(width: geometry.size.width, height: geometry.size.height * 0.7)
                }
            }
            .navigationBarTitle("Criar Receita")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                if !self.receitaViewModel.receita.title.isEmpty {
                    CloudKitHelper.save(item: self.receitaViewModel.receita) { (result) in
                        switch result {
                        case .success(let newItem):
                            print("saved")
                        case .failure(let err):
                            print(err.localizedDescription)
                        }
                    }
                    self.receitaViewModel.receita = Recipe(title: "", description: "", category: .bread, totalAmoountOfFlour: 0, criterion: .grams, scope: .new)
                }
                print("Saved")
            }) { Text("Save")
            })
            .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
                
        }
    }
    
    func delete(at offsets: IndexSet) {
        print("delete")
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView()
    }
}
