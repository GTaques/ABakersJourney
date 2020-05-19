//
//  RecipeCardView.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 18/05/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI

struct RecipeCardView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.green)
                .cornerRadius(20)
            VStack {
                Text("Titulo")
                .font(Font.title)
                HStack {
                    HStack {
                        Image(systemName: "timer")
                        Text("00:02 m")
                    }
                    
                }
            }
            
        }
       
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView()
    }
}
