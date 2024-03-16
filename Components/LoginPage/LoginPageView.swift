//
//  LoginPage.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 13/03/24.
//

import Foundation
import SwiftUI

struct LoginPage:  View {
    
    @Binding var isAuth: Bool;
    @State var uid: String = UserDefaults.standard.string(forKey: "uid") ?? ""
    @State var secret: String = UserDefaults.standard.string(forKey: "secret") ?? ""
    @State private var isLoading: Bool = false;
    
    func voidFunc() -> Void {}
    
    var body: some View {
        
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
                        text: $uid,
                        prompt: Text("UID")
                            .foregroundStyle(.gray)
                    )
                    .padding(10)
                    .border(Color.white)
                    .foregroundColor(.gray)
                    .padding(8)
                    
                    SecureField(
                        "password",
                        text: $secret,
                        prompt: Text("Secret")
                            .foregroundStyle(Color.gray)
                    )
                    .padding(10)
                    .border(Color.white)
                    .padding(8)
                    .foregroundColor(.gray)
                }
                Button(action: {
                    
                    UserDefaults.standard.set(uid, forKey: "uid")
                    UserDefaults.standard.set(secret, forKey: "secret")
                    connexion()
                }, label: {
                    Text("SIGN IN")
                        .foregroundStyle(.orange)
                })
                .disabled(!(uid != "" && secret != ""))
                .frame(maxWidth: .infinity)
                .padding(10)
                .border(.orange)
                .padding(8)
        
                
            }
        }
        .font(Font.custom("IBMPlexMono-Regular", size: 12))
        .padding(30)
    }
    
    func connexion() {
        CredManager.shared.connexion { loading in
            isLoading = loading
        } onSucces: {
            isAuth = true
            UserDefaults.standard.set(isAuth, forKey: "isAuth")
        } onError: { error in
            print(error)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }
}
