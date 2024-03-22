//
//  UserDetails.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 22/03/24.
//

import Foundation
import SwiftUI

struct UserDetailType {
    var name: String = "";
    var detail: String = "";
}

struct UserDetails: View {
    @State var detail_1: UserDetailType;
    @State var detail_2: UserDetailType;
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                Text(detail_1.name)
                    .font(Font.custom("IBMPlexMono-Regular", size: 14).weight(.bold))
                    .lineLimit(1).minimumScaleFactor(0.01)
                    .padding(.bottom, 2)
                Text(detail_1.detail)
                    .font(Font.custom("IBMPlexMono-Regular", size: 18))
                    .lineLimit(1).minimumScaleFactor(0.01)
            }
            .frame(maxHeight: .infinity)
            VStack(alignment: .center) {
                Text(detail_2.name)
                    .font(Font.custom("IBMPlexMono-Regular", size: 14).weight(.bold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.01)
                    .padding(.bottom, 2)
                Text(detail_2.detail)
                    .font(Font.custom("IBMPlexMono-Regular", size: 18))
                    .lineLimit(1)
                    .minimumScaleFactor(0.01)
            }
            .frame(maxHeight: .infinity)
        }
        .frame(height: 180)
        .foregroundStyle(.white)
    }
}
