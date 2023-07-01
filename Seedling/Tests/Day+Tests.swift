// Copyright Team Seedling ©

import XCTest
@testable import Seedling

final class Day_Tests: XCTestCase
{

    // TODO: Test adding dailyTaskSection doesn't add to previous days
    // TODO: adding dailyTaskSection adds to today and all future days
    // TODO: removing a dailyTaskSection only removes it for any created future days
    
    var database: Database!
    
    
    override func setUp()
    {
        super.setUp()
        database = createDatabase()
    }
    
    func test_addingDailyTaskSectionsDoesntAddToPreviousDays()
    {
        populateTestDatabaseDaysInRange(database, range: .past)
        let days = Day.allDays(context: database.context)
        for day in days
        {
            XCTAssertEqual(day.dailyTaskSections?.count, 0)
        }
    }

    func test_addingDailyTaskSectionAddsToTodayAndFuture()
    {
        populateTestDatabaseDaysInRange(database, range: .today)
        populateTestDatabaseDaysInRange(database, range: .future)
        let dailyTaskSection = DailyTaskSection(context: database.context)
        // TODO: Finish up here!
        let days = Day.allDays(context: database.context)
        for day in days
        {
            XCTAssertEqual(day.dailyTaskSections?.count, 1)
        }
    }
}


extension Day_Tests
{
    
    enum DateRange
    {
        case past
        case today
        case future
        
        var range: Range<Int>
        {
            switch self
            {
            case .past: return -2..<0
            case .today: return 0..<1
            case .future: return 0..<3
            }
        }
    }
    
    func createDatabase() -> Database
    {
        let database = Database(containerName: "Seedling")
        database.reset()
        return database
    }
    
    func populateTestDatabaseDaysInRange(_ database: Database, range: DateRange)
    {
        for i in range.range
        {
            let day = Day(context: database.context)
            day.date = Date(timeIntervalSinceNow: TimeInterval(i * 360 * 24))
        }
    }
    
    
}
