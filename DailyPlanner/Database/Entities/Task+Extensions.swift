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
    
    static func allUnfinishedHistoricalTasks(in context: Context) -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.predicate = NSPredicate(format: "completed ==", false)
        
        let result = (try? context.fetch(request)) ?? []
        return result
    }
}
