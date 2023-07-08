//
//  Task+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import Foundation
import CoreData

extension Task
{
    var identifier: String
    {
        "taskCellIdentifier"
    }
    
    static func make(content: String? = nil, in context: Context) -> Task
	{
        let task = Task(context: context)
        task.createdDate = Date()
        task.completed = false
        task.content = content
        return task
    }
    
    static func allUnfinishedTasks(in context: Context, before date: Date) -> [Task]
    {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.predicate = NSPredicate(format: "completed == %@ AND dailyTaskSection.day.date < %@", NSNumber(value: false), date as NSDate)
        
        let result = (try? context.fetch(request)) ?? []
        return result
    }
}
