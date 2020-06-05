//
//  TodoView.swift
//  DailyPlannerUITests
//
//  Created by Joshua Grant on 6/5/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import XCTest

class TodoView: BaseElement
{
    lazy var addPriorityButton = view.buttons["add.priority"].firstMatch
    lazy var addTodoButton = view.buttons["add.todo"].firstMatch
    
    var priorityTextViews: [TaskCell]
    {
        view.tables.cells.matching(identifier: "priority.cell").allElementsBoundByIndex.map {
            TaskCell(in: $0)
        }
    }
    
    var todoTextViews: [TaskCell]
    {
        view.tables.cells.matching(identifier: "todo.cell").allElementsBoundByIndex.map {
            TaskCell(in: $0)
        }
    }
    
    func priorityView(at index: Int) -> TaskCell
    {
        priorityTextViews[index]
    }
    
    func todoView(at index: Int) -> TaskCell
    {
        todoTextViews[index]
    }
    
    func addPriority()
    {
        addPriorityButton.tap()
    }
    
    func addTodo()
    {
        addTodoButton.tap()
    }
}
