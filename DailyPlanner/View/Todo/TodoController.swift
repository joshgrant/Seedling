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
	
	var editingSection: Section?
	
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
		// We should use the diffable data source to do this... we can use the NSDiffableDataSourceReference with core data
		(delegate as? TodoDelegate)?.tableView = tableView
		(delegate as? TodoDelegate)?.dayProvider = dayProvider
		
//		tableView.dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, _) -> UITableViewCell? in
//
//		})
	}
	
	override func configureDataSource()
	{
		(dataSource as? TodoDataSource)?.cellTextViewDelegate = self
	}
}
