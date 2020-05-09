//
//  DayProvider.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import CoreData

class DayProvider {
    
    private var _day: Day? {
        willSet {
            NotificationCenter.default.post(name: .dayProviderWillUpdateDay, object: self, userInfo: ["newDay": newValue as Any])
        }
        didSet {
            NotificationCenter.default.post(name: .dayProviderDidUpdateDay, object: self, userInfo: ["day": _day as Any])
        }
    }
    
    var day: Day {
        get {
            if let day = _day {
                return day
            }
            
            let request: NSFetchRequest<Day> = Day.fetchRequest()
            let first = try? Database.context.fetch(request).first
            
            if let first = first {
                _day = first
                return _day!
            } else {
                _day = Day.make(date: Date())
                
                _day?.addToTodos(Task.make(content: "Mow the lawn"))
                _day?.addToTodos(Task.make(content: "Take out the trash"))
                _day?.addToPriorities(Task.make(content: "Be awesome"))
                
                Database.save()
                
                return _day!
            }
        } set {
            _day = newValue
        }
    }
    
    var tomorrow: Day {
        guard let date = day.date else { return Day.make(date: Date()) }
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date > %@", date as NSDate)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        fetchRequest.fetchLimit = 1
        
        let result = try? Database.context.fetch(fetchRequest)
        
        if let tomorrow = result?.first {
            return tomorrow
        } else {
            let day = Day.make(date: date.addingTimeInterval(60 * 60 * 24))
            Database.save()
            return day
        }
    }
    
    var yesterday: Day {
        guard let date = day.date else { return Day.make(date: Date()) }
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date < %@", date as NSDate)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        let result = try? Database.context.fetch(fetchRequest)
        
        if let yesterday = result?.first {
            return yesterday
        } else {
            let day = Day.make(date: date.addingTimeInterval(-60 * 60 * 24))
            Database.save()
            return day
        }
    }
}

extension NSNotification.Name {
    static let dayProviderWillUpdateDay = NSNotification.Name("me.joshgrant.DailyPlanner.dayProviderWillUpdateDay")
    static let dayProviderDidUpdateDay = NSNotification.Name("me.joshgrant.DailyPlanner.dayProviderDidUpdateDay")
}
