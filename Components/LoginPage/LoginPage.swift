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
    @State private var isError: Bool = false;
    
    func voidFunc() -> Void {}
    
    var body: some View {
        VStack {
            Spacer()
            if (!isLoading) {
                VStack {
                    Image("42_logo_orange")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 120, height: 120)
                    Text("Born to code?")
                        .font(Font.custom("IBMPlexMono-Regular", size: 32))
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
                        .foregroundColor(.white)
                        .padding(8)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        
                        SecureField(
                            "password",
                            text: $secret,
                            prompt: Text("Secret")
                                .foregroundStyle(Color.gray)
                        )
                        .padding(10)
                        .border(Color.white)
                        .padding(8)
                        .foregroundColor(.white)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    }
                    
                    Button(action: {
                        UserDefaults.standard.set(uid, forKey: "uid")
                        UserDefaults.standard.set(secret, forKey: "secret")
                        connexion()
                    }, label: {
                        Text("SIGN IN")
                            .foregroundStyle(.orange)
                            .padding(4)
                    })
                    .disabled(!(uid != "" && secret != ""))
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .border(.orange)
                    .padding(8)
                    
                }
            }
            else {
                ZStack {
                    ProgressView() {
                        Text("Signing in...")
                            .foregroundStyle(.white)
                    }.frame(width: 100, height: 100)
                        .tint(.white)
                        .background(.clear)
                }
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .font(Font.custom("IBMPlexMono-Regular", size: 14))
        .padding(30)
        .alert(isPresented: $isError) {
            Alert(title: Text("Error"), message: Text("Error while trying to connect"), dismissButton: .cancel())
        }
    }
    
    func connexion() {
        CredManager.shared.connexion { loading in
            isLoading = loading
        } onSucces: {
            isAuth = true
            UserDefaults.standard.set(isAuth, forKey: "isAuth")
        } onError: { error in
            print(error)
            isError = true;
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }
}
