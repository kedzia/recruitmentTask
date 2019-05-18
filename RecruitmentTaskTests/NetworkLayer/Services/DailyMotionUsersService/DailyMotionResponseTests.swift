//
//  DailyMotionResponseTests.swift
//  RecruitmentTaskTests
//
//  Created by Adam Kędzia on 18/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import XCTest

class DailyMotionResponseTests: XCTestCase {

    func testCodable() {
        let response = TestHelper.getDailyMotionUsersResponse()
        let result = try! JSONDecoder.init().decode(DailyMotionUsersResponse.self, from: response)
        
        XCTAssertEqual(result.users.count, 10)
    }


}
