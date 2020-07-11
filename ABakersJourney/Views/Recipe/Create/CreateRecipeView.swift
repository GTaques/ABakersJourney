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
//    @ObservedObject var ingredientsViewModel: IngredientsViewModel = IngredientsViewModel()
    
    @State var showingCreateIngredient: Bool = false
    @State var showingActionSheet: Bool = false
    @State var showingImagePicker: Bool = false
    @State var showingAlert: Bool = false
    @State var sourceType: SourceType = .camera
    @State var criterion: Criteria = .grams
    
    //Recipe Properties
    @State var image: UIImage?
    var createdAt = Date()
    
   
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
                        Section(header: Text("Ingredients")) {
                            TextField("Quantidade Total de Farinha", text: self.$receitaViewModel.receita.totalAmountOfFlour).keyboardType(.numberPad)
                            Picker("", selection: self.$receitaViewModel.receita.criterion) {
                                ForEach(Criteria.allCases, id: \.self) { criterion in
                                    Text(criterion.rawValue)
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                            if self.receitaViewModel.receita.criterion == .grams {
                                List {
                                    ForEach(self.receitaViewModel.receita.ingredients.indices, id: \.self) { i in
                                        TextField(self.receitaViewModel.receita.ingredients[i].name, text: self.$receitaViewModel.receita.ingredients[i].amount).keyboardType(.numberPad)
                                    }
                                }
                            } else {
                                List {
                                    ForEach(self.receitaViewModel.receita.ingredients.indices, id: \.self) { i in
                                       TextField(self.receitaViewModel.receita.ingredients[i].name, text: self.$receitaViewModel.receita.ingredients[i].percentage).keyboardType(.numberPad)
                                    }
                                }
                            }
                        }
                        Button(action: {
                            self.showingCreateIngredient = true
                        }) {
                            Text("Adicionar Ingrediente")
                        }
                    }
                }
            }.sheet(isPresented: self.$showingCreateIngredient) {
                CreateIngredientView(receitaViewModel: self.receitaViewModel, showingCreateIngredient: self.$showingCreateIngredient, criterion: self.$criterion)
            }
            .navigationBarTitle("Criar Receita")
            .navigationBarItems(leading: Button(action: {
                CoreDataService.shared.flush()
            }) {
                Text("Flush")
            }, trailing: Button(action: {
                if !self.receitaViewModel.receita.title.isEmpty {
                    CoreDataService.shared.saveRecipe(recipe: self.receitaViewModel.receita) {
                        print("Saved!")
                    }
                } else {
                    self.showingAlert.toggle()
                }
            }) {
                Text("Save")
            })
        }.gesture(DragGesture().onChanged { _ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        .alert(isPresented: self.$showingAlert) {
            Alert(title: Text("Please add a title"), dismissButton: Alert.Button.default(Text("Ok")))
        }
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
