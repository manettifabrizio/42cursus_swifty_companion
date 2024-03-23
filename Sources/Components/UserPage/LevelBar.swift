//
//  LevelBar.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 21/03/24.
//

import Foundation
import SwiftUI

struct LevelBar: View {
    let level: Double
    //    @Binding var color: Color
    
    var sizeProgressBar: CGFloat {
        return CGFloat(level.truncatingRemainder(dividingBy: 1))
        // getLevel > Double % 1 > CGFloat
    }
    
    var displayLevel: String {
        return "Level \(Int(level)) - \(Int(sizeProgressBar * 100))%"
        // "Level XX - XX%"
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(
                        width: geometry.size.width * sizeProgressBar,
                        height: 30
                    )
                    .foregroundColor(Color("custom_orange"))
                Text(displayLevel)
                    .frame(width: geometry.size.width, height: 30)
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 30)
    }
}
