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
    var avatarUrl: URL? { get }
}


extension Result {
    typealias T = User
    func convertResult(_ result: Result<T, Error>) -> Result<User, Error> {
        switch result {
        case .success(let users):
            return .success(users)
        case .failure(let error):
            return .failure(error)
        }
    }
}
