//
//  ScheduleDataSource.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class ScheduleDataSource: TabContentDataSource
{
	// MARK: - Variables
	
	weak var cellTextViewDelegate: CellTextViewDelegate?
	
	// MARK: - Data source
	
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return dayProvider?.day.schedulesArray.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let identifier = cellIdentifier(for: indexPath)
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        // This is crashing, but maybe that's better than not crashing?
		if let scheduleCell = cell as? ScheduleCell, let schedule = dayProvider?.day.schedulesArray[indexPath.row]
		{
			scheduleCell.configure(with: schedule)
			scheduleCell.delegate = cellTextViewDelegate
		}
		
		return cell
	}
	
	// MARK: - Utility
	
	override func cellIdentifier(for indexPath: IndexPath) -> String
	{
		return "scheduleCell"
	}
}
