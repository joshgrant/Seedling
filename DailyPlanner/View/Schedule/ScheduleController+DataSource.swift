//
//  ScheduleController+DataSource.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

extension ScheduleController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dayProvider?.day.schedulesArray.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath)
		let schedule = dayProvider?.day.schedulesArray[indexPath.row]
		let hour = schedule?.twelveHour ?? -1
		
		if let scheduleCell = cell as? ScheduleCell {
			scheduleCell.hourLabel.text = "\(hour)"
			
			if indexPath.row == 0 {
				scheduleCell.meridiemLabel.text = "AM"
			} else if indexPath.row == 7 {
				scheduleCell.meridiemLabel.text = "PM"
			}
			
			
			scheduleCell.configure(with: nil, delegate: self)
		}
		
		//        cell.textLabel?.text = "\(hour)"
		return cell
	}
}
