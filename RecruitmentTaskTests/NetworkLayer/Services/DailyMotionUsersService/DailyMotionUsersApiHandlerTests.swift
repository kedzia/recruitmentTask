//
//  DailyMotionUsersApiHandlerTests.swift
//  RecruitmentTaskTests
//
//  Created by Adam Kędzia on 16/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import XCTest

class DailyMotionUsersApiHandlerTests: XCTestCase {
    let apiHandler = DailyMotionUsersApiHandler()
    
    func testRequestCreation() {
        let request = apiHandler.createRequest()
        XCTAssertEqual(request.url, URL.init(string: "https://api.dailymotion.com/users?fields=avatar_360_url,username"))
        XCTAssertEqual(request.httpMethod, "GET")
    }
    
    func testParsingResponse() {
        do {
            let data = TestHelper.getDailyMotionUsersResponse()
            let result = try apiHandler.parseData(data)
            XCTAssertEqual(result.count, 10)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testParsingMalformedResponse() {
        do {
            let data = TestHelper.getMalformedDataWithGithubUsers()
            let result = try apiHandler.parseData(data)
            print(result)
            XCTFail()
        } catch {
        }
    }
}
