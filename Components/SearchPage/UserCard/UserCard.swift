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
    @State var selectedUser: User?;
    @State var isSelectedUser: Bool = false;
    @State var isLoadingUser: Bool = false;
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.clear)
                        .frame(width: 40, height: 40)
                        .padding()
                } else if phase.error != nil {
                    Color.red
                } else {
                    Color.blue
                }
            }
            .frame(width: 40, height: 40)
            Text(user.login)
                .foregroundStyle(.white)
            Spacer()
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .frame(maxWidth: .infinity)
        .border(Color.white)
        .listRowInsets(EdgeInsets())
        .navigationDestination(isPresented: $isSelectedUser) {
            UserView(user: selectedUser)
        }
        .onTapGesture {
            getUser(login: user.login)
        }
    }
    
    func getUser(login: String) {
        UserManager.shared.getUser(login: login) {
            val in
            isLoadingUser = val
        } onSucces: { user in
            UIApplication.shared.inputViewController?.dismissKeyboard()
            self.selectedUser = user
            self.isSelectedUser = true
        } onError: { error in
            print(error)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }
}
