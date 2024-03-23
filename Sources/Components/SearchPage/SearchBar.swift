//
//  SearchBarView.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 21/03/24.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var users_list: [UserCardType];
    @Binding var login: String;
    @Binding var isSearchBarActive: Bool;
    @Binding var isSearchLoading: Bool;
    @FocusState private var focused
    
    var cleanLogin: String {
        let allowedCharacters = CharacterSet(charactersIn: "qwertyuiopasdfghjklzxcvbnm-")
        return login.lowercased().components(separatedBy: allowedCharacters.inverted).joined(separator: "")
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    TextField(
                        "search",
                        text: $login,
                        prompt: Text("Login")
                            .foregroundStyle(.gray)
                    )
                    .autocapitalization(.none)
                    .submitLabel(.search)
                    .focused($focused)
                    .padding(10)
                    .foregroundColor(.white)
                    .onChange(of: login) {
                        isSearchLoading = true
                        UserManager.shared.searchUserByCampus(login: cleanLogin) { val in
                            isSearchLoading = val }
                    onSucces: { users in
                        users_list = users.map({ user in
                            UserCardType(
                                login: user.login,
                                image: user.image
                            )
                        })
                    } onError: { error in
                        print(error)
                    }
                        
                    }
                    .navigationBarTitle("")
                    
                    Image(systemName: login.count > 0 ? "xmark" : "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
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
                .padding([.top, .bottom], 8)
            }
            
        }
        .onChange(of: focused) {
            isSearchBarActive = login.count > 0 ? true : focused;
        }
        .animation(.default, value: isSearchBarActive)
        
    }
}
