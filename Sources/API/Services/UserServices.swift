//
//  UserServices.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 13/03/24.
//

import Foundation
import Combine

class UserServices {
    static var shared = UserServices()

    init() {}

    func getCred() -> AnyPublisher<Credential, Error> {
        let request = prepareGetCred()
        return URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .receive(on: DispatchQueue.main)
                .decode(type: CredentialResponse.self, decoder: JSONDecoder())
                .map({ cred in
                    Credential(data: cred)
                })
                .eraseToAnyPublisher()
    }

    private func prepareGetCred() -> URLRequest {
        let url = URL(string: BASE_URL + "/oauth/token")
        var request = URLRequest(url: url!)
        var requestBodyComponents = URLComponents()
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        requestBodyComponents.queryItems = [URLQueryItem(name: "grant_type", value: "client_credentials"),
                                            URLQueryItem(name: "client_id",
                                                         value: UserDefaults.standard.string(forKey: "uid") ?? ""),
                                            URLQueryItem(name: "client_secret",
                                                         value: UserDefaults.standard.string(forKey: "secret") ?? "")]
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        return request
    }

    func getUser(login: String) -> AnyPublisher<User, Error> {
        let request = prepareGetUser(login: login)
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .map({ user in
                User(data: user)
            })
            .eraseToAnyPublisher()
    }

    private func prepareGetUser(login: String) -> URLRequest {
        let url = URL(string: BASE_URL + "/v2/users/" + login)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "access_token") ?? "")",
                          forHTTPHeaderField: "Authorization")
        return request
    }

    func searchUserbyCampus(login: String) -> AnyPublisher<[CampusUser], Error> {
        let url = prepareSearchUserByCampus(login: login)
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: [CampusUserResponse].self, decoder: JSONDecoder())
            .map({ users in
                users.map { user in
                    return CampusUser(data: user)
                }
            })
            .eraseToAnyPublisher()
    }

    private func prepareSearchUserByCampus(login: String) -> URLRequest {
        let url = URL(string: BASE_URL + "/v2/campus/1/users?range%5Blogin%5D=\(login),\(login)z")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "access_token") ?? "")",
                         forHTTPHeaderField: "Authorization")
        return request
    }
}
