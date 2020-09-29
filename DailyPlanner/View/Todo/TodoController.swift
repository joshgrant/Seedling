//
//  TodoController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TodoController: TabContentController
{
	// MARK: - Variables
	
	enum Section: Int {
		case priorities
		case todos
	}
	
	// MARK: - Factories
	
	override class func makeDelegate() -> TabContentDelegate
	{
		return TodoDelegate()
	}
	
	override class func makeDataSource(dayProvider: DayProvider) -> TabContentDataSource
	{
		return TodoDataSource(dayProvider: dayProvider)
	}
	
	override class func makeTabBarItem() -> UITabBarItem
	{
		return UITabBarItem(
			title: "To Do",
			image: .type(.todo),
			selectedImage: .type(.todoSelected))
	}
	
	override class func makeCellClassIdentifiers() -> [CellClassIdentifier]
	{
		return [
			.init(cellClass: TaskCell.self, cellReuseIdentifier: "taskCell")
		]
	}
	
	override func configureDelegate()
	{
		(delegate as? TodoDelegate)?.tableView = tableView
		(delegate as? TodoDelegate)?.dayProvider = dayProvider
        (delegate as? TodoDelegate)?.database = database
	}
	
	override func configureDataSource()
	{
		(dataSource as? TodoDataSource)?.cellTextViewDelegate = self
        (dataSource as? TodoDataSource)?.database = database
	}
}
