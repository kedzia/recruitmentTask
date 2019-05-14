//
//  UserData.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 14/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

protocol User {
    var username: String { get }
    var avatarUrl: URL { get }
}
