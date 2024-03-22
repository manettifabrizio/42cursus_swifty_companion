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
    @State private var users_list: [UserCardType] = []
    @State private var login: String = ""
    @State private var isSearchLoading: Bool = false;
    @State private var isUserLoadingError: Bool = false;
    @State private var isSearchBarActive: Bool = false
    
    func resetCred() {
        isAuth = false;
        UserDefaults.standard.set("", forKey: "uid")
        UserDefaults.standard.set("", forKey: "secret")
        UserDefaults.standard.set(false, forKey: "isAuth")
        
    }
    
    var body: some View {
        VStack {
            if (!isSearchBarActive) {
                Spacer()
                
                Text("Search any user")
                    .font(Font.custom("IBMPlexMono-Regular", size: 30))
                    .foregroundStyle(.white)
            }
            
            SearchBar(users_list: $users_list, login: $login, isSearchBarActive: $isSearchBarActive, isSearchLoading: $isSearchLoading)
            
            if (isSearchBarActive && login.count > 0) {
                UserCards(users_list: $users_list, isSearchLoading: $isSearchLoading, isUserLoadingError: $isUserLoadingError)
            }
            
            Spacer()
            
            Button(action: {resetCred()}, label: {
                Text("Logout")
                    .padding()
            })
            .foregroundColor(.gray)
            .font(Font.custom("IBMPlexMono-Regular", size: 16))
            
        }
        .font(Font.custom("IBMPlexMono-Regular", size: 14))
        .padding(30)
        .alert(isPresented: $isUserLoadingError) {
            Alert(title: Text("Error"), message: Text("Error while loading user."), dismissButton: .cancel())
        }
    }
}
