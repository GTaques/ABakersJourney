//
//  RecipesView.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 18/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI

struct RecipesView: View {
    
    var recipes = ["dale", "dfale", "dale"]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(self.recipes, id: \.self) { recipe in
                        RecipeCardView().frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.2)
                    }
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
