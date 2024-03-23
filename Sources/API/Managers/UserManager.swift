//
//  UserManager.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 16/03/24.
//

import Foundation
import Combine

class UserManager {
    static var shared = UserManager()
    private var cancellables = Set<AnyCancellable>()

    init() {}

    func getUser(login: String,
                 onLoading: @escaping (Bool) -> Void,
                 onSucces: @escaping (User) -> Void,
                 onError: @escaping (String) -> Void) {
        onLoading(true)
        CredManager.shared.checkCred {
            UserServices.shared.getUser(login: login)
                .sink { completion in
                    switch completion {
                    case .failure:
                        onLoading(false)
                        onError("Erreur dans le getUser")
                    case .finished:
                        onLoading(false)
                    }
                } receiveValue: { user in
                    print(user)
                    onSucces(user)
                }
                .store(in: &self.cancellables)
        } onError: { error in
            onError(error)
        }
    }

    public func searchUserByCampus(login: String,
                                   onLoading: @escaping (Bool) -> Void,
                                   onSucces: @escaping ([CampusUser]) -> Void,
                                   onError: @escaping (String) -> Void ) {
        onLoading(true)
        CredManager.shared.checkCred {
            UserServices.shared.searchUserbyCampus(login: login)
                .sink { completion in
                    switch completion {
                    case .failure:
                        onLoading(false)
                        onError("Erreur in searchUserByCampus")
                    case .finished:
                        onLoading(false)
                    }
                } receiveValue: { users in
                    onSucces(users)
                }
                .store(in: &self.cancellables)
        } onError: { error in
            onError(error)
        }
    }
}
