//
//  Task+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import Foundation

extension Task
{
    static func make(in context: Context) -> Task
    {
        let task = Task(context: context)
        task.createdDate = Date()
        return task
    }
    
    static func make(content: String, in context: Context) -> Task
	{
        let task = Task(context: context)
        task.createdDate = Date()
        task.content = content
        return task
    }
}
