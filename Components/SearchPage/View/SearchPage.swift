//
//  SearchPage.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 13/03/24.
//

import Foundation
import SwiftUI

struct SearchPage:  View {
    
    @Binding var isAuth: Bool
    @State private var search_value: String = ""
    
    func resetCred() {
        isAuth = false;
        UserDefaults.standard.set("", forKey: "uid")
        UserDefaults.standard.set("", forKey: "secret")
        
    }
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Text("Search any user")
                .font(Font.custom("IBMPlexMono-Regular", size: 30))
                .foregroundStyle(.white)
            VStack {
                VStack {
                    HStack {
                        TextField(
                            "search",
                            text: $search_value,
                            prompt: Text("Login or name")
                                .foregroundStyle(.gray)
                        )
                        .padding(10)
                        
                        Image(systemName: "magnifyingglass")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .border(Color.white)
                    .foregroundColor(.black)
                    .padding(8)
                }
                
            }
            Spacer()
            
            Button(action: resetCred, label: { Text("Logout")})
                .opacity(0.5)
                .foregroundColor(.white)
                .font(Font.custom("IBMPlexMono-Regular", size: 16))

        }
        .font(Font.custom("IBMPlexMono-Regular", size: 12))
        .padding(30)
        
    }
}
