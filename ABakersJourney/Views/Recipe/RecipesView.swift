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
    
    @ObservedObject var receitasViewModel: ReceitasViewModel = ReceitasViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Newest").bold().font(.title)
                                Spacer()
                                Button(action: {
                                }) {
                                    Text("Ver Mais")
                                }
                            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(self.receitasViewModel.recipes.indices , id: \.self) { i in
                                        NavigationLink(destination: DetailsRecipe(recipe: self.receitasViewModel.recipes[i])) {
                                            RecipeCardView(recipe: self.receitasViewModel.recipes[i], width: geometry.size.width * 0.38, height: geometry.size.width * 0.32).frame(width: geometry.size.width * 0.38, height: geometry.size.width * 0.32)
                                        }
                                    }
                                }
                            }
                        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
                    }
                }
            }.onAppear(perform: loadRecipes)
            .navigationBarTitle(Text("Hello Gabriel"))
        }
        
    }
    
    func loadRecipes() {
        CoreDataService.shared.getRecipes(predicate: nil, completion: { recipes in
            self.receitasViewModel.recipes = recipes
            print("Recipes: \(self.receitasViewModel.recipes)")
            if self.receitasViewModel.recipes.count > 0 {
                CoreDataService.shared.getIngredients(predicate: NSPredicate(format: "belongsTo == %@", self.receitasViewModel.recipes[0].objectID)) { ingredients in
                    print(ingredients)
                }
            }
        })
        
        
        //        var recipesArray = [Recipe]()
//        EntityService.fetch(entity: recipe) { (result) in
//            switch result {
//            case .success(let newItem):
//                recipesArray.append(newItem as! Recipe)
//                self.receitasViewModel.receitas = recipesArray
//                if !self.receitasViewModel.receitas.isEmpty {
//                    self.receitasViewModel.receitas[0].scope = .new
//                    print("Loaded Recipes!")
//                }
//                
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
        }
    
}

//struct RecipesView_Previews: PreviewProvider {
////    static var receitasViewModel = ReceitasViewModel()
//    static var previews: some View {
//        RecipesView(receitasViewModel: receitasViewModel)
//    }
//}
