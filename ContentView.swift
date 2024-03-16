//
//  ContentView.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 12/03/24.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var isAuth: Bool = UserDefaults.standard.bool(forKey: "isAuth");
    
    @ViewBuilder
    var body: some View {
        ZStack {
            GIFView(type: .name("42-monolythe-repeat-3"))
                .edgesIgnoringSafeArea(.all)
                .background(.black)
            if (!isAuth) {
                LoginPage(isAuth: $isAuth)
            } else {
                SearchPage(isAuth: $isAuth)
            }
        }
    }
}

#Preview {
    ContentView()
}
