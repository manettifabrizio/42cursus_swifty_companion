//
//  UserCard.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 21/03/24.
//

import Foundation
import SwiftUI


struct UserCard: View {
    @State var user: UserCardType;
    @Binding var selectedUser: User?;
    @Binding var isSelectedUser: Bool;
    @Binding var isUserLoadingError: Bool;
    @Binding var isUserLoading: Bool;
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipped()
                } else if phase.error != nil {
                    Color.red
                } else {
                    Color.blue
                }
            }
            .frame(width: 60, height: 60)
            Text(user.login)
                .foregroundStyle(.white)
            Spacer()
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .frame(maxWidth: .infinity)
        .border(Color.white)
        .listRowInsets(EdgeInsets())
        .padding(.bottom, 8)
        .onTapGesture {
            getUser(login: user.login)
        }
    }
    
    func getUser(login: String) {
        UserManager.shared.getUser(login: login) {
            val in
            isUserLoading = val
        } onSucces: { user in
            UIApplication.shared.inputViewController?.dismissKeyboard()
            self.selectedUser = user
            self.isSelectedUser = true
        } onError: { error in
            print(error)
            self.isUserLoadingError = true;
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }
}
