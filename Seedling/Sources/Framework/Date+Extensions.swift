//
//  Date+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/23/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import Foundation

extension Date
{
	// Taken from https://stackoverflow.com/a/39944152/9447565
	func makeDayPredicate() -> NSPredicate
	{
		let calendar = Calendar.autoupdatingCurrent
		var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
		
		components.hour = 0
		components.minute = 0
		components.second = 0
		let startDate = calendar.date(from: components)
		
		components.hour = 23
		components.minute = 59
		components.second = 59
		let endDate = calendar.date(from: components)
		
		return NSPredicate(format: "date >= %@ AND date =< %@", argumentArray: [startDate!, endDate!])
	}
    
    static var uses12HourTime: Bool
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        let string = formatter.string(from: Date())
        let am = formatter.amSymbol!
        let pm = formatter.pmSymbol!
        
        return string.contains(am) || string.contains(pm)
    }
}
