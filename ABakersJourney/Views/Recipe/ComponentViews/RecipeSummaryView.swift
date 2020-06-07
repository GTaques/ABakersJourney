//
//  RecipeSummaryView.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 24/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI
import Combine

struct RecipeSummaryView: View {
    
    @ObservedObject var receitaViewModel: ReceitaViewModel
    
    var body: some View {
        List(receitaViewModel.receita.ingredients.indices, id: \.self) { index in
            HStack {
                Text(self.receitaViewModel.receita.ingredients[index].amount.isEmpty ? "" : self.receitaViewModel.receita.ingredients[index].name)
                Text(self.receitaViewModel.receita.ingredients[index].amount.isEmpty ? "" : "\(self.receitaViewModel.receita.ingredients[index].amount)g")
                Spacer()
                Text(self.receitaViewModel.receita.ingredients[index].amount.isEmpty ? "" : "\(self.receitaViewModel.receita.ingredients[index].percentage)%")
                
            }
            
        }.onAppear {
            UITableView.appearance().separatorStyle = .none
        }
        
    }
}


struct RecipeSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
