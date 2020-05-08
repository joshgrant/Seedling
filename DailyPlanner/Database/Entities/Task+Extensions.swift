//
//  Task+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import Foundation

extension Task {
 
    static func make(content: String) -> Task {
        let todo = Task(context: Database.context)
        todo.createdDate = Date()
        todo.content = content
        return todo
    }
}
