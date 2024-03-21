//
//  SearchPage.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 13/03/24.
//

import Foundation
import SwiftUI

struct UserCardType: Hashable, Identifiable {
    var id = UUID()
    var login: String = "";
    var image: String = "";
}

struct SearchPage:  View {
    
    @Binding var isAuth: Bool
    @State var list: [UserCardType] = []
    @State var login: String = ""
    @State var isLoading: Bool = false;
    @State var isError: Bool = false;
    @State private var isSearchBarActive: Bool = false
    @FocusState private var focused
    
    func resetCred() {
        isAuth = false;
        //        UserDefaults.standard.set("", forKey: "uid")
        //        UserDefaults.standard.set("", forKey: "secret")
        UserDefaults.standard.set(false, forKey: "isAuth")
        
    }
    
    var cleanLogin: String {
        let allowedCharacters = CharacterSet(charactersIn: "qwertyuiopasdfghjklzxcvbnm-")
        return login.lowercased().components(separatedBy: allowedCharacters.inverted).joined(separator: "")
    }
    
    var body: some View {
        
        VStack {
            if (!isSearchBarActive) {
                Spacer()
                
                Text("Search any user")
                    .font(Font.custom("IBMPlexMono-Regular", size: 30))
                    .foregroundStyle(.white)
            }
            
            VStack {
                VStack {
                    HStack {
                        TextField(
                            "search",
                            text: $login,
                            prompt: Text("Login or name")
                                .foregroundStyle(.gray)
                        )
                        .focused($focused)
                        .padding(10)
                        .foregroundColor(.gray)
                        .onChange(of: login) {
                            print("login", login.count, isSearchBarActive)
                            list = []
                            isLoading = true
                            if (login.count > 2) {
                                UserManager.shared.searchUserByCampus(login: cleanLogin) { val in
                                    isLoading = val }
                            onSucces: { users in
                                list.append(contentsOf: users.map({ user in
                                    UserCardType(
                                        login: user.login,
                                        image: user.image
                                    )
                                }))
                            } onError: { error in
                                print(error)
                            }
                            }
                        }
                        .navigationBarTitle("")
                        
                        Image(systemName: login.count > 0 ? "x.circle" : "magnifyingglass")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                            .padding()
                            .onTapGesture {
                                if (login.count > 0) {
                                    focused = false // Unfocus the TextField
                                    login = "";
                                    isSearchBarActive = false
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) // Dismiss the keyboard
                                }
                            }
                        
                    }
                    .border(Color.white)
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                }
                
            }
            .onChange(of: focused) {
                    isSearchBarActive = login.count > 0 ? true : focused;
            }
            .animation(.default, value: isSearchBarActive)
            
            if (isSearchBarActive && login.count > 0) {
                UserCards(users_list: $list, isSearchLoading: $isLoading)
            }
            
            Spacer()
            
            Button(action: {resetCred()}, label: { Text("Logout")})
                .foregroundColor(.white)
                .font(Font.custom("IBMPlexMono-Regular", size: 16))
                .opacity(0.5)
            
        }
        .font(Font.custom("IBMPlexMono-Regular", size: 12))
        .padding(30)
        .background(.black)
        .alert(isPresented: $isError) {
            Alert(title: Text("Error"), message: Text("Error while searching for \(login)"), dismissButton: .cancel())
        }
    }
}
