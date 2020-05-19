//
//  CreateRecipeView.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 18/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI

struct CreateRecipeView: View {
    
    var ingredients: [String] = ["Farinha", "Água", "Sal", "Levain"]
    var steps: [String] = ["Ativar Fermento", "Autólise", "Adicionar Levain", "Adicionar Sal", "Laminação", "Dobra #1", "Dobra #2", "Dobra #3", "Modelagem"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informações Básicas")) {
                    Text("Nome")
                    Text("Descrição")
                }
                Section(header: Text("Ingredientes")) {
                    List(ingredients, id: \.self) { ingredient in
                        HStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(.red)
                            Text(ingredient)
                        }
                        
                    }
                    Button(action: {
                    }) {
                        Text("Adicionar")
                    }
                }
                Section(header: Text("Etapas")) {
                    List(steps, id: \.self) { step in
                        HStack {
                            Image(systemName: "1.circle.fill")
                            Text(step)
                        }
                    }
                }
            }
            .navigationBarTitle("Criar Receita")
            .navigationBarItems(trailing: Button(action: {
                print("Saved!")
            }) { Text("Save")
            })
        }
        
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView()
    }
}
