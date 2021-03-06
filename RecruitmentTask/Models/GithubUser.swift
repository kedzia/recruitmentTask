//
//  GithubUser.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 14/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

struct GithubUser: User, Codable {
    let username: String
    let avatarUrl: URL?
    let service = "Github"

    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarUrl = "avatar_url"
    }
}

