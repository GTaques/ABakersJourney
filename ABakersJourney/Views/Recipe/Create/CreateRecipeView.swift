//
//  CreateRecipeView.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 18/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI
import CloudKit

struct CreateRecipeView: View {
    
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var receitaViewModel: ReceitaViewModel = ReceitaViewModel()
    @ObservedObject var ingredientsViewModel: IngredientsViewModel = IngredientsViewModel()
    
    @State var showingCreateIngredient: Bool = false
    @State var showingActionSheet: Bool = false
    @State var showingImagePicker: Bool = false
    @State var sourceType: SourceType = .camera
    @State var criterion: Criteria = .grams
    
    //Recipe Properties
    @State var title = ""
    @State var description = ""
    @State var image: UIImage?
    @State var totalAmountOfFlour = ""
    var createdAt = Date()
    //
    //    @State var mockRecipe: MockRecipe = MockRecipe(title: "", description: "", image: UIImage(), totalAmountOfFlour: "", ingredients: [
    //        MockIngredient(name: "Farinha", amount: "", percentage: "", isFarinha: true),
    //        MockIngredient(name: "Água", amount: "", percentage: "", isFarinha: false),
    //        MockIngredient(name: "Sal", amount: "", percentage: "", isFarinha: false),
    //        MockIngredient(name: "Levain", amount: "", percentage: "", isFarinha: false)
    //    ])
    //
    //    @State var mockIngredients: [MockIngredient] = [
    //        MockIngredient(name: "Farinha", amount: "", percentage: "", isFarinha: true),
    //        MockIngredient(name: "Água", amount: "", percentage: "", isFarinha: false),
    //        MockIngredient(name: "Sal", amount: "", percentage: "", isFarinha: false),
    //        MockIngredient(name: "Levain", amount: "", percentage: "", isFarinha: false)
    //    ]
    
    
    var steps: [String] = ["Ativar Fermento", "Autólise", "Adicionar Levain", "Adicionar Sal", "Laminação", "Dobra #1", "Dobra #2", "Dobra #3", "Modelagem"]
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    RecipeSummaryView(receitaViewModel: self.receitaViewModel, headerImage: self.$image).frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                    Form {
                        Section(header: Text("Informações Básicas")) {
                            TextField("Nome", text: self.$receitaViewModel.receita.title)
                            TextField("Descrição", text: self.$receitaViewModel.receita.description)
                            Button(action: {
                                self.showingActionSheet = true
                            }) {
                                Text("Adicionar Imagem")
                            }.actionSheet(isPresented: self.$showingActionSheet) {
                                ActionSheet(title: Text("Adicionar Imagem"), buttons: [
                                    ActionSheet.Button.default(Text("Tirar Foto"), action: {
                                        self.sourceType = .camera
                                        self.showingImagePicker = true
                                    }),
                                    ActionSheet.Button.default(Text("Escolher Foto"), action: {
                                        self.sourceType = .library
                                        self.showingImagePicker = true
                                    }),
                                    .cancel()
                                ])
                            }.sheet(isPresented: self.$showingImagePicker) {
                                ImagePicker(image: self.$image, source: self.$sourceType)
                            }
                        }
                        Section(header: Text("Ingredientes")) {
                            TextField("Quantidade Total de Farinha", text: self.$receitaViewModel.receita.totalAmountOfFlour).keyboardType(.numberPad)
                            Picker("", selection: self.$receitaViewModel.receita.criterion) {
                                ForEach(Criteria.allCases, id: \.self) { c in
                                    Text(c.rawValue).tag(c.rawValue)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            if self.receitaViewModel.receita.criterion == .grams {
                                List {
                                    ForEach(self.receitaViewModel.receita.ingredients.indices, id:\.self) { i in
                                        TextField(self.receitaViewModel.receita.ingredients[i].name, text: self.$receitaViewModel.receita.ingredients[i].amount).keyboardType(.numberPad)
                                    }
                                }
                            } else {
                                List {
                                    ForEach(self.receitaViewModel.receita.ingredients.indices, id:\.self) { i in
                                        TextField(self.receitaViewModel.receita.ingredients[i].name, text: self.$receitaViewModel.receita.ingredients[i].percentage).keyboardType(.numberPad)
                                    }
                                }
                            }
                            Button(action: {
                                self.showingCreateIngredient = true
                            }) {
                                Text("Adicionar Ingrediente")
                            }
                        }
                    }.frame(width: geometry.size.width, height: geometry.size.height * 0.7)
                }
            }.sheet(isPresented: self.$showingCreateIngredient) {
                CreateIngredientView(receitaViewModel: self.receitaViewModel, ingredients: self.$receitaViewModel.receita.ingredients, showingCreateIngredient: self.$showingCreateIngredient, criterion: self.$criterion)
            }
            .navigationBarTitle("Criar Receita")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                if !self.receitaViewModel.receita.title.isEmpty {
                    let recipe = Recipe(context: self.managedObjectContext)
                    recipe.title = self.receitaViewModel.receita.title
                    recipe.description_ = self.receitaViewModel.receita.description
//                    recipe.ingredient = NSSet(array: self.receitaViewModel.receita.ingredients)
                   
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print(error)
                    }
                    

                }
                print("Saved")
            }) {
                Text("Save")
            })
        }
            .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
    }
}

func delete(at offsets: IndexSet) {
    print("delete")
}


//struct CreateRecipeView_Previews: PreviewProvider {
//    static var receitasViewModel = ReceitasViewModel()
//    static var previews: some View {
//        CreateRecipeView(receitasViewModel: receitasViewModel)
//    }
//}
