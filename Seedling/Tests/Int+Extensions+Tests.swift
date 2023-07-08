//
//  Int+Extensions+Tests.swift
//  DailyPlannerTests
//
//  Created by Joshua Grant on 9/6/22.
//  Copyright © 2022 Joshua Grant. All rights reserved.
//

import XCTest

final class Int_Extensions_Tests: XCTestCase
{
    func test_convert24HourTimeToTwelveHourTime_midnight()
    {
        let value = 0
        let result = value.convert24HourTimeToTwelveHourTime()
        XCTAssertEqual(result, 12)
    }
    
    func test_convert24HourTimeToTwelveHourTime_noon()
    {
        let value = 12
        let result = value.convert24HourTimeToTwelveHourTime()
        XCTAssertEqual(result, 12)
    }
    
    func test_convert24HourTimeToTwelveHourTime_am()
    {
        let value = 5
        let result = value.convert24HourTimeToTwelveHourTime()
        XCTAssertEqual(result, 5)
    }
    
    func test_convert24HourTimeToTwelveHourTime_pm()
    {
        let value = 18
        let result = value.convert24HourTimeToTwelveHourTime()
        XCTAssertEqual(result, 6)
    }
}
