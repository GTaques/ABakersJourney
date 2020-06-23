//
//  ContentView.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 18/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
//    @EnvironmentObject var receitasViewModel: ReceitasViewModel 
    @ObservedObject var receitasViewModel: ReceitasViewModel = ReceitasViewModel()
    
    var body: some View {
        TabView {
            RecipesView(receitasViewModel: receitasViewModel)
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Receitas")
            }
            CreateRecipeView(receitasViewModel: receitasViewModel)
                .tabItem {
                    Image(systemName: "plus.square.fill")
                    Text("Criar Receita")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
