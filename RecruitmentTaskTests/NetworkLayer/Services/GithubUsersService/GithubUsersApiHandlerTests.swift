//
//  GithubUsersApiHandlerTests.swift
//  RecruitmentTaskTests
//
//  Created by Adam Kędzia on 15/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import XCTest

class GithubUsersApiHandlerTests: XCTestCase {
    let apiHandler = GithubUsersApiHandler()
    
    func testRequestCreation() {
        let request = apiHandler.createRequest()
        XCTAssertEqual(request.url, URL.init(string: "https://api.github.com/users"))
        XCTAssertEqual(request.httpMethod, "GET")
    }
    
    func testParsingResponse() {
        do {
            let data = TestHelper.getDataWithGithubUsers()
            let result = try apiHandler.parseData(data)
            XCTAssertEqual(result.count, 3)
        } catch {
            XCTFail()
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
