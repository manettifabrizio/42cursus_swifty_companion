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
    
    var body: some View {
        VStack {
            if (users_list.unique().count > 0) {
                List(users_list.unique()) { user in
                    UserCard(user: user)
                }
                .scrollContentBackground(.hidden)
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity)
                .padding(0)
                .listStyle(PlainListStyle())
            }
            else {
                Text("No user found.")
                    .foregroundStyle(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if (isSearchLoading == true) {
                ZStack {
                    Color.black
                    ProgressView() {
                        Text("Searching...")
                    }.frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .tint(.white)
                }
            }
        }
    }
}
