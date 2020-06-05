//
//  TaskCell.swift
//  DailyPlannerUITests
//
//  Created by Joshua Grant on 6/5/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import Foundation

class TaskCell: BaseElement
{
    func setDone(to isDone: Bool)
    {
        if isDone
        {
            view.accessibilityIncrement()
        }
        else
        {
            view.accessibilityDecrement()
        }
    }
    
    func setContent(to content: String)
    {
        view.typeText("\(content)\n")
    }
}
