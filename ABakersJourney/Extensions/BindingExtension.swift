//
//  BindingExtension.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 07/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation
import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}
