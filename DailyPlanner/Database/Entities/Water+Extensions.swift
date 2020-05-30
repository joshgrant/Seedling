//
//  Water+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import CoreData

extension Water
{
	static func make(in context: Context) -> Water
	{
		let water = Water(context: context)
		water.createdDate = Date()
		water.amount = 0
		return water
	}
}
