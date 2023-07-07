//
//  DayProvider.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//
// Hello world!
import CoreData

class DayProvider
{
    weak var database: Database?
    
    init(database: Database)
    {
        self.database = database
    }
    
    private var _day: Day?
    {
        willSet
        {
            NotificationCenter.default.post(name: .dayProviderWillUpdateDay, object: self, userInfo: ["newDay": newValue as Any])
        }
        didSet
        {
            NotificationCenter.default.post(name: .dayProviderDidUpdateDay, object: self, userInfo: ["day": _day as Any])
        }
    }
    
    var day: Day
    {
        get
        {
            if let day = _day
            {
                return day
            }
            
            let request: NSFetchRequest<Day> = Day.fetchRequest()
			request.predicate = Date().makeDayPredicate()
			request.fetchLimit = 1
			
            let first = try? database?.context.fetch(request).first
            
            if let first = first
            {
                _day = first
                return _day!
            }
            else
            {
                _day = Day.make(date: Date(), in: database!.context)
                
                database?.save()
                
                return _day!
            }
        }
        set
        {
            _day = newValue
        }
    }
    
    var tomorrow: Day
    {
        guard let date = day.date else { return Day.make(date: Date(), in: database!.context) }
        return DayProvider.findOrMakeDay(date: date.tomorrow, context: database!.context)
    }
    
    var yesterday: Day
    {
        guard let date = day.date else { return Day.make(date: Date(), in: database!.context) }
        return DayProvider.findOrMakeDay(date: date.yesterday, context: database!.context)
    }
    
    var today: Day
    {
        resetDay()
        return day
    }
	
	func resetDay()
    {
		_day = nil
	}
    
    static func findOrMakeDay(date: Date, context: Context) -> Day
    {
        
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        fetchRequest.predicate = date.makeDayPredicate()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        if let result = (try? context.fetch(fetchRequest))?.first
        {
            return result
        }
        else
        {
            let day = Day.make(date: date, in: context)
            try? context.save()
            return day
        }
    }
}

extension NSNotification.Name
{
    static let dayProviderWillUpdateDay = NSNotification.Name("me.joshgrant.DailyPlanner.dayProviderWillUpdateDay")
    static let dayProviderDidUpdateDay = NSNotification.Name("me.joshgrant.DailyPlanner.dayProviderDidUpdateDay")
}
