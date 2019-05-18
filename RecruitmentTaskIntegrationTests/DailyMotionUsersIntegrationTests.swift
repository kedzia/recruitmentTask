//
//  DailyMotionUsersIntegrationTests.swift
//  RecruitmentTaskIntegrationTests
//
//  Created by Adam Kędzia on 16/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import XCTest

class DailyMotionUsersIntegrationTests: XCTestCase {
    var service: DailyMotionUsersService!
    
    override func setUp() {
        super.setUp()
        service = DailyMotionUsersService.init(apiHandler: DailyMotionUsersApiHandler(),
                                          apiClient: ApiClient())
    }
    
    func testExample() {
        let completedExpectation = expectation(description: "complete")
        service.getDailyMotionUsers { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 10)
                completedExpectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}

