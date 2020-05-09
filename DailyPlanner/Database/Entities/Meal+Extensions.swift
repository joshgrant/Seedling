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
	static func make() -> Meal
	{
		let meal = Meal(context: Database.context)
		meal.createdDate = Date()
		return meal
	}
}
