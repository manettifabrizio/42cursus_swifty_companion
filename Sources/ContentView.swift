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
        NavigationStack{
            ZStack {
                PlayerView()
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
}

#Preview {
    ContentView()
}
