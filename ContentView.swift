//
//  ContentView.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 12/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    func voidFunc() -> Void {}
    
    var body: some View {
        ZStack {
            GIFView(type: .name("42-monolythe-repeat-3"))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    Image("42_logo_orange")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text("Born to code?")
                        .font(Font.custom("IBMPlexMono-Regular", size: 30))
                        .foregroundStyle(.white)
                }
                VStack {
                    VStack {
                        TextField(
                            "email",
                            text: $email,
                            prompt: Text("Email")
                                .foregroundStyle(.gray)
                        )
                        .padding(10)
                        .border(Color.white)
                        .foregroundColor(.black)
                        .padding(8)
                        
                        SecureField(
                            "password",
                            text: $password,
                            prompt: Text("Password")
                                .foregroundStyle(.gray)
                        )
                        .padding(10)
                        .border(Color.white)
                        .padding(8)
                    }
                    Button(action: voidFunc, label: {
                        Text("SIGN IN")
                            .foregroundStyle(.orange)
                    })
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .border(.orange)
                    .padding(8)
                    
                    Text("forgot password?")
                        .opacity(0.5)
                        .foregroundColor(.white)
                        .font(Font.custom("IBMPlexMono-Regular", size: 16))
                    
                }
            }
            .font(Font.custom("IBMPlexMono-Regular", size: 12))
            .padding(30)
        }
    }
}

#Preview {
    ContentView()
}
