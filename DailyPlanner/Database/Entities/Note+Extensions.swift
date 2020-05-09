//
//  Note+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import CoreData

extension Note
{
	static func make() -> Note
	{
		let note = Note(context: Database.context)
		note.createdDate = Date()
		return note
	}
}
