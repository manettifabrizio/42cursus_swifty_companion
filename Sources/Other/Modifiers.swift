//
//  Modifiers.swift
//  42find
//
//  Created by Fabrizio Manetti on 23/03/24.
//

import Foundation
import SwiftUI

struct UnstyledListModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .listRowSeparator(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .listStyle(PlainListStyle())
    }
}

struct UnstyledListElementModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity)
            .listRowInsets(EdgeInsets())
    }
}
