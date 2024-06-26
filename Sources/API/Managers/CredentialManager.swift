//
//  CredentialManager.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 13/03/24.
//

import Foundation
import Combine

class CredManager {
    static var shared = CredManager()
    private var cancellables = Set<AnyCancellable>()

    init() {}

    func connexion(onLoading: @escaping (Bool) -> Void,
                   onSucces: @escaping () -> Void,
                   onError: @escaping (String) -> Void) {
        onLoading(true)
        UserServices.shared.getCred()
            .sink { completion in
                switch completion {
                case .failure:
                    onLoading(false)
                    onError("Error in connexion")
                case .finished:
                    onLoading(false)
                }
            } receiveValue: { cred in
                UserDefaults.standard.set(cred.access_token, forKey: "access_token")
                UserDefaults.standard.set(Date().addingTimeInterval(TimeInterval(cred.expires_in)),
                                          forKey: "expiration")
                onSucces()
            }
            .store(in: &cancellables)
    }

    func checkCred(onSucces: @escaping () -> Void,
                   onError: @escaping (String) -> Void) {
        if Date() >= UserDefaults.standard.object(forKey: "expiration") as? Date ?? Date() {
            UserServices.shared.getCred()
                .sink { completion in
                    switch completion {
                    case .failure:
                        onError("error dans checkCred")
                        print("error dans checkCred")
                    case .finished:
                        print("finish")
                    }
                } receiveValue: { cred in
                    print("change cred")
                    UserDefaults.standard.set(cred.access_token, forKey: "access_token")
                    UserDefaults.standard.set(Date().addingTimeInterval(TimeInterval(cred.expires_in)),
                                              forKey: "expiration")
                    let delayInSeconds: TimeInterval = 0.5
                    DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
                        onSucces()
                    }
                }
                .store(in: &cancellables)
        } else {
            onSucces()
        }
    }

}
