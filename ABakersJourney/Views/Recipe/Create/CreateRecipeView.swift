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
    
    @ObservedObject var receitasViewModel: ReceitasViewModel
    @ObservedObject var receitaViewModel: ReceitaViewModel = ReceitaViewModel()
    
    @State var showingCreateIngredient: Bool = false
    @State var showingActionSheet: Bool = false
    @State var showingImagePicker: Bool = false
    @State var isEditMode: Bool = true
    @State var sourceType: SourceType = .camera
    @State var image: UIImage?
    
    
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
                        RecipeIngredientsFormView(receitaViewModel: self.receitaViewModel, criterion: self.$receitaViewModel.receita.criterion, showingCreateIngredient: self.showingCreateIngredient)
                    }.frame(width: geometry.size.width, height: geometry.size.height * 0.7)
                }
            }
            .navigationBarTitle("Criar Receita")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                if !self.receitaViewModel.receita.title.isEmpty {
                    EntityService.save(item: self.receitaViewModel.receita) { (result) in
                        switch result {
                        case .success( _):
                            IngredientService.bulkSave(items: self.receitaViewModel.receita.ingredients, parentEntity: self.receitaViewModel.receita) { result in
                                
                            }
                            print("saved")
                        case .failure(let err):
                            print(err.localizedDescription)
                        }
                    }
                    self.receitaViewModel.receita = Recipe(title: "", description: "", category: .bread, totalAmountOfFlour: "", criterion: .grams, scope: .new)
                }
                print("Saved")
            }) {
                Text("Save")
            }).gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        }
    }
}

func delete(at offsets: IndexSet) {
    print("delete")
}


struct CreateRecipeView_Previews: PreviewProvider {
    static var receitasViewModel = ReceitasViewModel()
    static var previews: some View {
        CreateRecipeView(receitasViewModel: receitasViewModel)
    }
}
