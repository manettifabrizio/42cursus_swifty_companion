//
//  UserCard.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 18/03/24.
//

import Foundation
import SwiftUI

extension Array where Element: Hashable {
    func unique() -> [Element] {
        Array(Set(self))
    }
}

struct UserCards: View {
    @Binding var users_list: [UserCardType];
    @Binding var isSearchLoading: Bool;
    @State var isUserLoading: Bool = false;
    @Binding var isUserLoadingError: Bool;
    @State var selectedUser: User?;
    @State var isSelectedUser: Bool = false;
    
    
    var body: some View {
        VStack {
        if (!isSearchLoading && !isUserLoading) {
                if (users_list.unique().count > 0) {
                    List(users_list.unique()) { user in
                        UserCard(user: user,
                                 selectedUser: $selectedUser,
                                 isSelectedUser: $isSelectedUser,
                                 isUserLoadingError: $isUserLoadingError,
                                 isUserLoading: $isUserLoading
                                )
                    }
                    .scrollContentBackground(.hidden)
                    .listRowSeparator(.hidden)
                    .frame(maxWidth: .infinity)
                    .listStyle(PlainListStyle())
                }
                else {
                    Text("No user found.")
                        .foregroundStyle(.white)
                }
        }
        else {
            ProgressView() {
                Text(isSearchLoading ? "Searching..." : "Loading user...")
                    .foregroundStyle(.white)
            }
        }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationDestination(isPresented: $isSelectedUser) {
                if let user = selectedUser {
                       UserView(user: user)
                   }
            }
    }
}
