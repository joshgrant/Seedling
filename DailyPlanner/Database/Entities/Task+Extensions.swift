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
	static func make(content: String) -> Task
	{
        let task = Task(context: Database.context)
        task.createdDate = Date()
        task.content = content
        return task
    }
    
    override class var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(keyPath: \Task.kind, ascending: true)]
    }
}
