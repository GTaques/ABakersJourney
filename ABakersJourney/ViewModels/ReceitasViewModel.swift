//
//  ReceitasViewModel.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 08/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI
import Combine
import CloudKit

class ReceitasViewModel: ObservableObject {
    @Published var receitas: [Recipe] = []
    @Published var auxBool: Bool = false
}
