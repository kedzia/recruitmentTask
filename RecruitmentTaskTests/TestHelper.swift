//
//  TestHelper.swift
//  RecruitmentTaskTests
//
//  Created by Adam Kędzia on 15/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

class TestHelper {
    
    static func getDataWithGithubUsers() -> Data {
        return TestHelper.getDataFromPath("github_users", type: "json")
    }
    
    static func getMalformedDataWithGithubUsers() -> Data {
        return TestHelper.getDataFromPath("github_users_malformed", type: "json")
    }
    
    static func getDailyMotionUsersResponse() -> Data {
        return TestHelper.getDataFromPath("dailymotion_response", type: "json")
    }
    
    static func getDataFromPath(_ path: String, type: String) -> Data {
        guard let pathString = Bundle(for: TestHelper.self).path(forResource: path, ofType: type) else {
            fatalError("\(path + type) not found")
        }
        
        guard let jsonString = try? NSString(contentsOfFile: pathString, encoding: String.Encoding.utf8.rawValue) else {
            fatalError("Unable to convert \(path + type) to String")
        }
        
        guard let jsonData = jsonString.data(using: String.Encoding.utf8.rawValue) else {
            fatalError("Unable to convert \(path + type) to NSData")
        }
        
        return jsonData
    }
}
