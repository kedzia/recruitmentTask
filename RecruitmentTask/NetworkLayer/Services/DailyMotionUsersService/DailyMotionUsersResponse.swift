//
//  DailyMotionUsersResponse.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 16/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

struct DailyMotionUsersResponse: Codable {
    let users: [DailyMotionUser]

    enum CodingKeys: String, CodingKey {
        case users = "list"
    }
}
