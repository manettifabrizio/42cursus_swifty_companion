//
//  AchievementDataModel.swift
//  swifty_companions
//
//  Created by Fabrizio Manetti on 14/03/24.
//

import Foundation

class AchievementData {
    let id: Int
    let achievement_id: Int
    let user_id: Int
    let login: String

    init(data: AchievementDataResponse) {
        self.id = data.id
        self.achievement_id = data.achievement_id
        self.user_id = data.user_id
        self.login = data.login
    }
}

class AchievementDataResponse: Codable {
    let id: Int
    let achievement_id: Int
    let user_id: Int
    let login: String
}
