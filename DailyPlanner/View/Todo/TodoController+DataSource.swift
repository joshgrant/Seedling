//
//  TodoController+DataSource.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

extension TodoController: UITableViewDataSource {
	
	func task(at indexPath: IndexPath) -> Task? {
		switch indexPath.row {
		case 0:
			return dayProvider?.day.prioritiesArray[indexPath.row]
		case 1:
			return dayProvider?.day.todosArray[indexPath.row]
		default:
			return nil
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return dayProvider?.day.priorities?.count ?? 0
		case 1:
			return dayProvider?.day.todos?.count ?? 0
		default:
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
		configure(taskCell: cell, at: indexPath)
		return cell
	}
	
	func configure(taskCell: UITableViewCell, at indexPath: IndexPath) {
		if let cell = taskCell as? TaskCell, let task = task(at: indexPath) {
			cell.configure(with: task)
			cell.delegate = self
		}
	}
}
