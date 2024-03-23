//
//  UserProjectNSkill.swift
//  42find
//
//  Created by Fabrizio Manetti on 23/03/24.
//

import Foundation
import SwiftUI

struct UserProjectNSkill: View {
    @State var name: String;
    @State var value: String;
    @State var value_style: any ShapeStyle;
    
    
    var body: some View {
        HStack {
            Text(name)
                .foregroundStyle(.white)
                .font(Font.custom("IBMPlexMono-Regular", size: 20).weight(.bold))
            Spacer()
            Text(value)
                .foregroundStyle(value_style)
                .font(Font.custom("IBMPlexMono-Regular", size: 20).weight(.bold))
        }
        .modifier(UnstyledListElementModifier())
    }
}
