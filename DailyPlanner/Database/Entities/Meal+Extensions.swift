//
//  Meal+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import CoreData

extension Meal
{
    static func make(in context: Context) -> Meal
	{
		let meal = Meal(context: context)
		meal.createdDate = Date()
		return meal
	}
}
