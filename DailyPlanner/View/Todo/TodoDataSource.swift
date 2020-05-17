//
//  TodoDataSource.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TodoDataSource: TabContentDataSource
{
	// MARK: - Variables
	
	weak var cellTextViewDelegate: CellTextViewDelegate?
	
	// MARK: - Data source
	
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 2
	}
	
	// TODO: Convert this to a section model
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		switch section
		{
		case 0:
			return dayProvider?.day.priorities?.count ?? 0
		case 1:
			return dayProvider?.day.todosArray.count ?? 0
		default:
			return 0
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let identifier = cellIdentifier(for: indexPath)
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
		
		if let taskCell = cell as? TaskCell, let task = task(for: indexPath)
		{
			taskCell.configure(with: task)
			taskCell.delegate = cellTextViewDelegate
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
	{
		return true
	}
	
	// MARK: - Utility
	
	override func cellIdentifier(for indexPath: IndexPath) -> String
	{
		return "taskCell"
	}
	
	func task(for indexPath: IndexPath) -> Task?
	{
		switch indexPath.section
		{
		case 0:
			return dayProvider?.day.prioritiesArray[indexPath.row]
		case 1:
			return dayProvider?.day.todosArray[indexPath.row]
		default:
			fatalError()
		}
	}
}
