//
//  ToDoTabUITests.swift
//  DailyPlannerUITests
//
//  Created by Joshua Grant on 5/30/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import XCTest
@testable import Seedling

class ToDoTabUITests: XCTestCase
{
    override func setUp() {
        // Clean the database
        Database.reset()
    }
    
    func testAddTask()
    {
        
        
//        let tablesQuery = XCUIApplication().tables
//        tablesQuery.children(matching: .cell).element(boundBy: 0).buttons["clearBubble"].tap()
//        tablesQuery.children(matching: .cell).element(boundBy: 1).buttons["clearBubble"].tap()
//        tablesQuery.children(matching: .cell).element(boundBy: 2).buttons["clearBubble"].tap()
//
//        let cell = tablesQuery.children(matching: .cell).element(boundBy: 3)
//        cell.buttons["clearBubble"].tap()
//        tablesQuery/*@START_MENU_TOKEN@*/.buttons["clearBubble"]/*[[".cells.buttons[\"clearBubble\"]",".buttons[\"clearBubble\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//        let textView = tablesQuery.children(matching: .cell).element(boundBy: 4).children(matching: .textView).element
//        textView.swipeLeft()
//        textView.swipeLeft()
//        cell.children(matching: .textView).element.swipeLeft()
//
    }
    
    func testDeleteTask()
    {
        
    }
    
    func testTaskContentRemainsAfterTabSwitch()
    {
        
    }
    
    func testTaskContentRemainsAfterBackgrounding()
    {
        
    }
    
    func testHittingReturnWithContentAddsNewTask()
    {
        
    }
    
    func testHittingReturnNoContentEndsEditing()
    {
        
    }
    
    func testCheckingTaskMarksAsComplete()
    {
        
    }
    
    func integrityTestForAllTaskFunctionality()
    {
        
    }
}
