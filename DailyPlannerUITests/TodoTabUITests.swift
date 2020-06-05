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
    // MARK: - Variables
    
    var app: XCUIApplication!
    
    lazy var tabBar = TabBar(in: app)
    lazy var todoView = TodoView(in: app)
    
    // MARK: - Initialization
    
    override func setUp() {
        continueAfterFailure = false
        
        // TODO: Because UI tests can't include code from the app,
        // we need to modify the app via launch arguments (which
        // are parsed when the app launches).
        // Not ideal, but otherwise, the UI tests will fail to
        // compile...
        
        app = XCUIApplication()
        
        app.launch(with: [ResetDatabase()])
    }
    
    // MARK: - Functions
    
    func testAddTask()
    {
        tabBar.select(tab: .toDo)
        
        // TODO: Need to reset the database
        
        XCTAssert(todoView.todoTextViews.count == 0)
        
        todoView.addTodo()
        
        XCTAssert(todoView.todoTextViews.count == 1)
        
        
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
