//
//  RecipesView.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 18/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI
import Combine

struct RecipesView: View {
    
    @ObservedObject var receitasViewModel: ReceitasViewModel
    var recipe: Recipe = Recipe()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Text("Hello Gabriel").font(.title).padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Newest").bold().font(.title)
                            Spacer()
                            Button(action: {
                                print("Ver todos")
                            }) {
                                Text("Ver Mais")
                            }
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(self.receitasViewModel.receitas.indices, id: \.self) { index in
                                    RecipeCardView(recipe: self.$receitasViewModel.receitas[index], width: geometry.size.width * 0.38, height: geometry.size.width * 0.32).frame(width: geometry.size.width * 0.38, height: geometry.size.width * 0.32)
                                }
                            }
                        }

                    }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Popular").bold().font(.title)
                            Spacer()
                            Button(action: {
                                print("Ver todos")
                            }) {
                                Text("Ver Mais")
                            }
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(self.receitasViewModel.receitas.indices, id: \.self) { index in
                                    VStack(alignment: .leading) {
                                        RecipeCardView(recipe: self.$receitasViewModel.receitas[index], width: geometry.size.width * 0.38, height: geometry.size.width * 0.4).frame(width: geometry.size.width * 0.38, height: geometry.size.width * 0.4)
                                        Text("Mixed Flours").bold()
                                        Text("by: Author Name")
                                    }

                                }
                            }
                        }

                    }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Last Made by You").bold().font(.title)
                            Spacer()
                            Button(action: {
                                print("Ver todos")
                            }) {
                                Text("Ver Mais")
                            }
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(self.receitasViewModel.receitas.indices, id: \.self) { index in
                                    VStack(alignment: .leading) {
                                        RecipeCardView(recipe: self.$receitasViewModel.receitas[index], width: geometry.size.width * 0.38, height: geometry.size.width * 0.46).frame(width: geometry.size.width * 0.38, height: geometry.size.width * 0.46)
                                        Text("Mixed Flours").bold()
                                        Text("by: Author Name")
                                    }

                                }
                            }
                        }

                    }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
                }
            }
        }.onAppear(perform: loadRecipes)
    }
    
    func loadRecipes() {
        var recipesArray = [Recipe]()
        EntityService.fetch(entity: recipe) { (result) in
            switch result {
            case .success(let newItem):
                recipesArray.append(newItem as! Recipe)
                self.receitasViewModel.receitas = recipesArray
                if !self.receitasViewModel.receitas.isEmpty {
                    self.receitasViewModel.receitas[0].scope = .new
                    print("Loaded Recipes!")
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var receitasViewModel = ReceitasViewModel()
    static var previews: some View {
        RecipesView(receitasViewModel: receitasViewModel)
    }
}
