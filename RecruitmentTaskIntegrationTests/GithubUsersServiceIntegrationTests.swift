//
//  RecruitmentTaskIntegrationTests.swift
//  RecruitmentTaskIntegrationTests
//
//  Created by Adam Kędzia on 16/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import XCTest

class GithubUsersServiceIntegrationTests: XCTestCase {
    var service: GithubUsersService!

    override func setUp() {
        super.setUp()
        service = GithubUsersService.init(apiHandler: GithubUsersApiHandler(),
                                          apiClient: ApiClient())
    }

    func testExample() {
        let completedExpectation = expectation(description: "complete")
        service.getGithubUsers { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 30)
                completedExpectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
