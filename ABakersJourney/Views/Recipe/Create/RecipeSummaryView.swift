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
    @Binding var headerImage: UIImage?
    
    var body: some View {
        VStack {
            HStack {
                Text(self.receitaViewModel.receita.totalAmountOfFlour.isEmpty ? "" : "Total de Farinha").bold()
                Text(self.receitaViewModel.receita.totalAmountOfFlour.isEmpty ? "" : "\(self.receitaViewModel.receita.totalAmountOfFlour)g").bold()
                Spacer()
                Text(self.receitaViewModel.receita.totalAmountOfFlour.isEmpty ? "" : "100%").bold()
            }.padding([.top, .leading, .trailing])
            List(self.receitaViewModel.receita.ingredients.indices, id: \.self) { index in
                HStack {
                    Text(self.receitaViewModel.receita.ingredients[index].amount.isEmpty ? "" : self.receitaViewModel.receita.ingredients[index].name)
                    Text(self.receitaViewModel.receita.ingredients[index].amount.isEmpty ? "" : "\(self.receitaViewModel.receita.ingredients[index].amount)g")
                    Spacer()
                    Text(self.receitaViewModel.receita.ingredients[index].amount.isEmpty ? "" : "\(self.receitaViewModel.receita.ingredients[index].percentage)%")
                }
            }.onAppear {
                    UITableView.appearance().separatorStyle = .none
                    UITableView.appearance().backgroundColor = .clear
            }
        }
    }
}


struct RecipeSummaryView_Previews: PreviewProvider {
    @State static var receitaVM: ReceitaViewModel = ReceitaViewModel()
    @State static var image: UIImage? = UIImage(named: "pao1")!
    
    static var previews: some View {
        
        RecipeSummaryView(receitaViewModel: receitaVM, headerImage: $image).onAppear() {
            
        }
    }
}
