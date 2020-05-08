//
//  Day+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import Foundation

extension Day {
    
    var prioritiesArray: [Task] {
        let set = priorities as? Set<Task>
        return set?.sorted(by: { $0.wrappedCreatedDate < $1.wrappedCreatedDate }) ?? []
    }
    
    var todosArray: [Task] {
        let set = todos as? Set<Task>
        return set?.sorted(by: { $0.wrappedCreatedDate < $1.wrappedCreatedDate }) ?? []
    }
    
    static func make(date: Date) -> Day {
        let day = Day(context: Database.context)
        day.createdDate = Date()
        day.date = date
        return day
    }
}
