//
//  ExtrasDataSource.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class ExtrasDataSource: TabContentDataSource
{
	// MARK: - Variables
	
	weak var cellTextViewDelegate: CellTextViewDelegate?
	
	// MARK: - Data source
	
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 4
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let identifier = cellIdentifier(for: indexPath)
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
		
		switch indexPath.section {
		case 0:
			if let meal = dayProvider?.day.meal {
				(cell as? MealsCell)?.configure(with: meal)
				(cell as? MealsCell)?.delegate = cellTextViewDelegate
			}
		case 1:
			if let water = dayProvider?.day.water {
				(cell as? WaterCell)?.configure(with: water)
			}
		case 2:
			if let pomodoro = dayProvider?.day.pomodoro {
				(cell as? PomodoroCell)?.configure(with: pomodoro)
			}
		case 3:
			if let note = dayProvider?.day.note {
				(cell as? NotesCell)?.configure(with: note)
				(cell as? NotesCell)?.delegate = cellTextViewDelegate
			}
		default:
			break
		}
		
		return cell
	}
}
