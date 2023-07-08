// Copyright Team Seedling ©

import XCTest
@testable import Seedling

final class Day_Tests: XCTestCase
{
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
        let taskSection = TaskSection(context: database.context)
        taskSection.title = "New Section"
        taskSection.propagate(to: database.context)
        let allDays = Day.allDays(context: database.context)
        for day in allDays
        {
            XCTAssertEqual(day.dailyTaskSections?.count, 1)
            XCTAssertEqual((day.dailyTaskSections?.anyObject() as! DailyTaskSection).title, "New Section")
        }
    }
    
    func test_removingDailyTaskSectionRemovesForFutureDays()
    {
        let taskSection = TaskSection(context: database.context)
        taskSection.title = "New Section"
        populateTestDatabaseDaysInRange(database, range: .past)
        populateTestDatabaseDaysInRange(database, range: .today)
        populateTestDatabaseDaysInRange(database, range: .future)
        let allDays = Day.allDays(context: database.context)
        for day in allDays
        {
            XCTAssertEqual(day.dailyTaskSections?.count, 1)
        }
        
        taskSection.delete(from: database.context)
        let todayAndFutureDays = Day.todayAndFutureDays(context: database.context)
        for day in todayAndFutureDays
        {
            XCTAssertEqual(day.dailyTaskSections?.count, 0)
        }
        let pastDays = Day.pastDays(context: database.context)
        for day in pastDays
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
            let date = Date(timeIntervalSinceNow: TimeInterval(i * 360 * 24))
            let day = Day.make(date: date, in: database.context)
        }
    }
    
    
}
