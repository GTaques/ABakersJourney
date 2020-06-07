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
    
    @State private var recipes: [Recipe] = [
        Recipe(title: "Tartine Country Bread", description: "Bem gostoso", flour: Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: "100"), water: Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""), salt: Ingredient(category: .Dough, name: "Sal", amount: "", percentage: ""), levain: Ingredient(category: .Levain, name: "Levain", amount: "", percentage: ""), ingredients: [Ingredient()]),
        Recipe(title: "Foccacia", description: "Bem gostoso", flour: Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: ""), water: Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""), salt: Ingredient(category: .Dough, name: "Sal", amount: "", percentage: ""), levain: Ingredient(category: .Levain, name: "Levain", amount: "", percentage: ""), ingredients: [Ingredient()]),
        Recipe(title: "Foccacia", description: "Bem gostoso", flour: Ingredient(category: .Dough, name: "Farinha", amount: "", percentage: ""), water: Ingredient(category: .Dough, name: "Água", amount: "", percentage: ""), salt: Ingredient(category: .Dough, name: "Sal", amount: "", percentage: ""), levain: Ingredient(category: .Levain, name: "Levain", amount: "", percentage: ""), ingredients: [Ingredient()])
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Hello Gabriel").font(.title)
                List {
                    ForEach(RecipeCategories.allCases, id: \.self) { rc in
                        VStack(alignment: .leading) {
                            Text(rc.rawValue).bold().font(.title)
                            ScrollView(.horizontal) {
                                HStack(spacing: 10) {
                                    ForEach(self.recipes.indices, id: \.self) { index in
                                        RecipeCardView(recipe: self.$recipes[index]).frame(width: geometry.size.width * 0.4, height: geometry.size.width * 0.35)
                                    }
                                }
                            }
                        }.listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 0))
                    }
                }.onAppear {
                    UITableView.appearance().separatorStyle = .none
                }
            }
        }
        
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
