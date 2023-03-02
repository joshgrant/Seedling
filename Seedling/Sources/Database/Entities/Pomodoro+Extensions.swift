//
//  Pomodoro+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import CoreData

extension Pomodoro
{
    static func make(in context: Context) -> Pomodoro
	{
		let pomodoro = Pomodoro(context: context)
		pomodoro.createdDate = Date()
		pomodoro.amount = 0
		
		return pomodoro
	}
}
