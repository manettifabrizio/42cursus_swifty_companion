//
//  UserView.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 21/03/24.
//

import Foundation
import SwiftUI

struct UserView: View {
    
    @State var user: User?;
    
    var body: some View {
        Text(user?.login ?? "")
            .foregroundStyle(.black)
    }
}
