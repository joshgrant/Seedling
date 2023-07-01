//
//  Day+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import Foundation
import CoreData

extension Day
{
    var prioritiesArray: [Task]
    {
        let set = priorities as? Set<Task>
		return set?.sorted(by: { $0.wrappedCreatedDate < $1.wrappedCreatedDate }) ?? []
    }

    var todosArray: [Task]
    {
        let set = todos as? Set<Task>
        return set?.sorted(by: {
            if $0.completed && !$1.completed { return false }
            if $1.completed && !$0.completed { return true }
            return $0.wrappedCreatedDate < $1.wrappedCreatedDate
        }) ?? []
    }
	
	var schedulesArray: [Schedule]
    {
		let set = schedules as? Set<Schedule>
		return set?.sorted(by: { $0.wrappedCreatedDate < $1.wrappedCreatedDate }) ?? []
	}
    
    static func make(date: Date, in context: Context) -> Day
    {
        let day = Day(context: context)
        day.createdDate = Date()
        day.date = date
		
		day.meal = Meal.make(in: context)
		day.water = Water.make(in: context)
        day.pomodoro = Pomodoro.make(in: context)
		day.note = Note.make(in: context)
		
        for i in 0 ... 23
        {
			day.addToSchedules(Schedule.make(hour: i, in: context))
		}
    
        for section in TaskSection.allSections(in: context)
        {
            let dailyTaskSection = DailyTaskSection(context: context)
            dailyTaskSection.taskSection = section
            dailyTaskSection.title = section.title
            dailyTaskSection.sortIndex = section.sortIndex
            day.addToDailyTaskSections(dailyTaskSection)
        }
        
        // TODO: Daily task sections that are created aren't added to today or any other created days
        // TODO: Same with delete
//        let todayAndFuture = Day.fetchRequest()
        // TODO: Set the predicate
//        let result = context.fetch(todayAndFuture)
//        for day in result {
//            // TODO: Add / remode the task sections we did in settings
//        }
//
        return day
    }
    
    static func allDays(context: Context) -> [Day]
    {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        return (try? context.fetch(fetchRequest)) ?? []
    }
    
    static func todayAndFutureDays(context: Context) -> [Day]
    {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        // TODO: Should be searching from the beginning minute of the day
        fetchRequest.predicate = NSPredicate(format: "date >= %@", NSDate())
        return (try? context.fetch(fetchRequest)) ?? []
    }
}
