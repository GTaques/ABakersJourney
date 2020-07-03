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
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var receitasViewModel: ReceitasViewModel = ReceitasViewModel()
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipes : FetchedResults<Recipe>
    
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
                                    let ingredient1 = Ingredient(context: self.managedObjectContext)
                                    ingredient1.isFarinha = true
                                    ingredient1.amount = "200"
                                    ingredient1.percentage = "100"
                                    ingredient1.belongsTo = Recipe(context: self.managedObjectContext)
                                    ingredient1.name = "Farinha"
                                    
                                    let ingredient2 = Ingredient(context: self.managedObjectContext)
                                    ingredient2.isFarinha = true
                                    ingredient2.amount = "200"
                                    ingredient2.percentage = "100"
                                    ingredient2.belongsTo = Recipe(context: self.managedObjectContext)
                                    ingredient2.name = "Agua"
                                    
                                    print("Added object")
                                    try? self.managedObjectContext.save()
                                }) {
                                    Text("Ver Mais")
                                }
                            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(self.recipes , id: \.self) { recipe in
                                        RecipeCardView(recipe: recipe, width: geometry.size.width * 0.38, height: geometry.size.width * 0.32).frame(width: geometry.size.width * 0.38, height: geometry.size.width * 0.32)
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
