//
//  DailyMotionApiHandler.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 16/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

class DailyMotionUsersApiHandler: ApiHandler {
    
    func parseData(_ data: Data) throws -> [DailyMotionUser] {
        let response = try JSONDecoder.init().decode(DailyMotionUsersResponse.self, from: data)
        return response.users
    }

    func createRequest(from parameters: [String: Any]? = nil) -> URLRequest {
        return URLRequest.init(url: URL.init(string: "https://api.dailymotion.com/users?fields=avatar_360_url,username")!)
    }

}
