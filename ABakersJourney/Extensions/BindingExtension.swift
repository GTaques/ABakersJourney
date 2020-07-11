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
    
    func unwrap(binding: Binding<Value?>, fallback: Value) -> Binding<Value> {
      return Binding(get: {
        binding.wrappedValue ?? fallback
      }, set: {
        binding.wrappedValue = $0
      })
    }
    
//    func unwrap2( fallback: Value) -> Binding<Value> {
//        return Binding(get: {
//            self.wrappedValue ?? fallback
//        }, set: {
//            self.wrappedValue = $0
//        })
//    }

}

extension Binding where Value == String? {
    func onNone(_ fallback: String) -> Binding<String> {
        return Binding<String>(get: {
            return self.wrappedValue ?? fallback
        }) { value in
            self.wrappedValue = value
        }
    }
}
