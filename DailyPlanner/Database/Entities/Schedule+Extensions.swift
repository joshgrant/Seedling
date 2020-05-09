//
//  Schedule+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import Foundation

extension Schedule
{
	static func make(hour: Int) -> Schedule
	{
		let schedule = Schedule(context: Database.context)
		schedule.createdDate = Date()
		schedule.hour = Int32(hour)
		return schedule
	}
	
	var twelveHour: Int {
		if hour < 12 {
			return Int(hour)
		} else {
			return Int(hour - 11)
		}
	}
}
