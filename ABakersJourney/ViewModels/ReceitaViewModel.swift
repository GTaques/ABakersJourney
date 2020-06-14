//
//  ReceitaViewModel.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 01/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI
import Combine

class ReceitaViewModel: ObservableObject {
    @Published var receita: Recipe = Recipe(title: "", description: "", category: .bread, totalAmoountOfFlour: 0, criterion: .grams, scope: .new)
//        didSet {
//            receita.calculatePercentages(criterion: self.receita.criterion)
//        }
   
    
//    init() {
//        self.receita =
//    }
    
    
}


struct ReceitaViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
