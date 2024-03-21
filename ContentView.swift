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
            if (!isAuth) {
                LoginPage(isAuth: $isAuth)
            } else {
                NavigationStack{
                    SearchPage(isAuth: $isAuth)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
