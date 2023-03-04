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
        app.launch(with: [.resetDatabase])
    }
    
    // MARK: - Functions
    
    func testAddTask()
    {
        tabBar.select(tab: .toDo)
        
        app.terminateAndActivate(with: [.resetDatabase])
        
        tabBar.select(tab: .toDo)
        
        XCTAssert(todoView.todoTextViews.count == 0, "The number of text views is: \(todoView.todoTextViews.count). It should be 0")
        
        todoView.addTodo()
        
        XCTAssert(todoView.todoTextViews.count == 1, "The number of text views is: \(todoView.todoTextViews.count). It should be 1.")
        
        var todo = todoView.todoView(at: 0)
        todo.setContent(to: "Take out the groceries")
        todo.setDone(to: true)
        
        todoView.todoView(at: 0).setContent(to: "")
        
        // Marking the todo as "Done" moves it to the bottom
        todo = todoView.todoView(at: 1)
        
        XCTAssert(todo.content == "Take out the groceries", "The content is \(todo.content ?? "nil"). It should be `Take out the groceries`.")
        XCTAssert(todo.isDone, "The status is \(todo.isDone). It should be true.")
    }
    
    func testDeleteTask()
    {
        tabBar.select(tab: .toDo)
        
        XCTAssert(todoView.todoTextViews.count == 0)
        
        todoView.addTodo()
        todoView.addTodo()
        todoView.addTodo()
        todoView.addTodo()
        todoView.addTodo()
        todoView.addTodo()
        todoView.addTodo()
        todoView.addTodo()
        
        XCTAssert(todoView.todoTextViews.count == 8)
        
        todoView.todoView(at: 3).delete()
        todoView.todoView(at: 5).delete()
        
        XCTAssert(todoView.todoTextViews.count == 6)
        
        todoView.addPriority()
        todoView.addPriority()
        todoView.addPriority()
        
        XCTAssert(todoView.priorityTextViews.count == 3)
        
        todoView.view.swipeDown()
        
        todoView.priorityView(at: 0).delete()
        todoView.priorityView(at: 0).delete()
        todoView.priorityView(at: 0).delete()
        
        XCTAssert(todoView.priorityTextViews.count == 0)
    }
    
    func testTaskContentRemainsAfterTabSwitch()
    {
        createDefaultTasks()
        verifyDefaultTasks()
        
        tabBar.select(tab: .schedule)
        tabBar.select(tab: .extras)
        tabBar.select(tab: .toDo)
        
        verifyDefaultTasks()
    }
    
    func testTaskContentRemainsAfterBackgrounding()
    {
        createDefaultTasks()
        verifyDefaultTasks()
        
        app.terminateAndActivate(with: [])
        
        verifyDefaultTasks()
    }
    
    func testCheckingTaskMarksAsComplete()
    {
        createDefaultTasks()
        
        todoView.priorityView(at: 3).setDone(to: true)
        
        XCTAssert(todoView.priorityView(at: 3).isDone)
    }
    
    func testAllTaskFunctionality()
    {
        XCTAssert(todoView.priorityTextViews.count == 0)
        XCTAssert(todoView.todoTextViews.count == 0)
        
        createDefaultTasks()
        verifyDefaultTasks()
        
        todoView.priorityView(at: 1).setDone(to: true)
        
        todoView.priorityView(at: 2).setContent(to: "Testing")
        XCTAssertEqual(todoView.priorityView(at: 2).content, "Testing")
        
        todoView.priorityView(at: 2).setContent(to: "")
        XCTAssertEqual(todoView.priorityView(at: 2).content, "")
        
        todoView.priorityView(at: 2).setDone(to: true)
        
        tabBar.select(tab: .extras)
        
        app.terminateAndActivate(with: [])
        
        tabBar.select(tab: .toDo)
        
        
        
        todoView.todoView(at: 2).delete()
        todoView.todoView(at: 3).delete()
        
        
        
        todoView.todoView(at: 1).setContent(to: "Trying this out")
        todoView.todoView(at: 2).setDone(to: true)
        todoView.todoView(at: 2).setDone(to: false)
        todoView.todoView(at: 2).setDone(to: true)
        todoView.todoView(at: 3).setContent(to: "")
        
        
    }
    
    // MARK: - Utility
    
    private var defaultPriorities: [String]
    {
        [
            "Exercise",
            "Eat healthy food",
            "Walk the dog",
            "Earn money"
        ]
    }
    
    private var defaultTodos: [String]
    {
        [
            "Take out groceries",
            "Bring home the bacon",
            "Wash the car",
            "Open mail",
            "Sweep the floor",
            "Wash windows"
        ]
    }
    
    private func createDefaultTasks()
    {
        todoView.addPriority()
        defaultPriorities
            .enumerated()
            .forEach { todoView.priorityView(at: $0.offset).setContent(to: $0.element) }
        todoView.priorityView(at: defaultPriorities.count).setContent(to: "")
        
        todoView.addTodo()
        defaultTodos
            .enumerated()
            .forEach { todoView.todoView(at: $0.offset).setContent(to: $0.element) }
        todoView.todoView(at: defaultTodos.count).setContent(to: "")
    }
    
    private func verifyDefaultTasks()
    {
        defaultPriorities
            .enumerated()
            .makeIterator()
            .forEach { XCTAssert(todoView.priorityView(at: $0.offset).content == $0.element) }
        
        defaultTodos
            .enumerated()
            .makeIterator()
            .forEach { XCTAssert(todoView.todoView(at: $0.offset).content == $0.element) }
    }
}
