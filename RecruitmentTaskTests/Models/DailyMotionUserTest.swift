//
//  DailyMotionUserTest.swift
//  RecruitmentTaskTests
//
//  Created by Adam Kędzia on 14/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import XCTest

class DailyMotionUserTest: XCTestCase {

    func testCodable() {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "dailymotion_users", ofType: "json") else {
            fatalError("dailymotion_users.json not found")
        }
        
        guard let jsonString = try? NSString(contentsOfFile: pathString, encoding: String.Encoding.utf8.rawValue) else {
            fatalError("Unable to convert dailymotion_users.json to String")
        }
        
        guard let jsonData = jsonString.data(using: String.Encoding.utf8.rawValue) else {
            fatalError("Unable to convert dailymotion_users.json to NSData")
        }
        
        let dailyMotionUsers = try! JSONDecoder().decode([DailyMotionUser].self, from: jsonData)
        
        XCTAssertEqual(dailyMotionUsers.count, 3)
        XCTAssertEqual(dailyMotionUsers[0].username, "sarahann-jacinta")
        XCTAssertEqual(dailyMotionUsers[0].avatarUrl?.absoluteString, "https://s1-ssl.dmcdn.net/AVM/360x360-png/iC2.jpg")
        XCTAssertEqual(dailyMotionUsers[1].username, "achyuth-sage")
        XCTAssertEqual(dailyMotionUsers[1].avatarUrl?.absoluteString, "https://s1-ssl.dmcdn.net/AVM/360x360-png/iC2.jpg")
        XCTAssertEqual(dailyMotionUsers[2].username, "devanie-zmya")
        XCTAssertEqual(dailyMotionUsers[2].avatarUrl?.absoluteString, "https://s1-ssl.dmcdn.net/AVM/360x360-png/iC2.jpg")
    }
}
