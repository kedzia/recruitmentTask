//
//  GithubUsersResponseHandler.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 15/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

class GithubUsersApiHandler: ApiHandler {

}

extension RequestHandler {
    func createRequest(from parameters: [String: Any]? = nil) -> URLRequest {
        return URLRequest(url: URL.init(string: "https://api.github.com/users")!)
    }
}

extension ResponseHandler {
    func parseData(_ data: Data) throws -> [GithubUser] {
        return try JSONDecoder.init().decode([GithubUser].self, from: data)
    }
}
