//
//  DailymotionUser.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 14/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

struct DailyMotionUser: User, Codable {
    let username: String
    let avatarUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case avatarUrl = "avatar_360_url"
    }
}
