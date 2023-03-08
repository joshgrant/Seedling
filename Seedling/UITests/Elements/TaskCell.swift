//
//  TaskCell.swift
//  DailyPlannerUITests
//
//  Created by Joshua Grant on 6/5/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import XCTest

class TaskCell: BaseElement
{
    // MARK: - Variables
    
    lazy var textView = view.textViews["todo.textView"]
    lazy var doneButton = view.buttons["todo.checkBox"]
    lazy var deleteButton = view.buttons["Delete"]
    
    lazy var selectAllButton = app.menus.menuItems["Select All"]
    lazy var cutButton = app.menus.menuItems["Cut"]
    
    var content: String?
    {
        textView.value as? String
    }
    
    var isDone: Bool
    {
        (doneButton.value as? String) == "checked"
    }
    
    weak var app: XCUIApplication!
    
    // MARK: - Initialization
    
    init(in view: XCUIElement, app: XCUIApplication) {
        self.app = app
        super.init(in: view)
    }
    
    // MARK: - Functions
    
    func setDone(to done: Bool)
    {
        if isDone != done {
            doneButton.tap()
        }
    }
    
    func setContent(to content: String)
    {
        textView.clearAndTypeText("\(content)\n")
    }
    
    func delete()
    {
        view.swipeLeft()
        deleteButton.tap()
    }
}
