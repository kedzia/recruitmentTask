//
//  GithubUserTest.swift
//  RecruitmentTaskTests
//
//  Created by Adam Kędzia on 14/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import XCTest
import RecruitmentTask

class GithubUserTest: XCTestCase {

    func testCodable() {
        let jsonData = TestHelper.getDataWithGithubUsers()
        let githubUsers = try! JSONDecoder().decode([GithubUser].self, from: jsonData)
        
        XCTAssertEqual(githubUsers.count, 3)
        XCTAssertEqual(githubUsers[0].username, "mojombo")
        XCTAssertEqual(githubUsers[0].avatarUrl?.absoluteString, "https://avatars0.githubusercontent.com/u/1?v=4")
        XCTAssertEqual(githubUsers[1].username, "defunkt")
        XCTAssertEqual(githubUsers[1].avatarUrl?.absoluteString, "https://avatars0.githubusercontent.com/u/2?v=4")
        XCTAssertEqual(githubUsers[2].username, "pjhyett")
        XCTAssertEqual(githubUsers[2].avatarUrl?.absoluteString, "https://avatars0.githubusercontent.com/u/3?v=4")

    }
}
