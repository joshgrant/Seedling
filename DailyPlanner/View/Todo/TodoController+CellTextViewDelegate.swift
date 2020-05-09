//
//  TodoController+CellTextViewDelegate.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

extension TodoController: CellTextViewDelegate {
	
	func textViewDidBeginEditing(_ textView: UITextView, in cell: UITableViewCell) {
		let indexPath = tableView.indexPath(for: cell)
		
		editingSection = Section(rawValue: indexPath?.section ?? 0)
	}
	
	func textViewDidChange(_ textView: UITextView, in cell: UITableViewCell) {
		tableView.performBatchUpdates({
			UIView.animate(withDuration: 0.0) {
				cell.contentView.setNeedsLayout()
				cell.contentView.layoutIfNeeded()
			}
		}, completion: nil)
	}
	
	func textViewDidEndEditing(_ textView: UITextView, in cell: UITableViewCell) {
		//		if textView.text == "" {
		//			// Delete the task,
		//			// Dismiss the keyboard
		//			textView.resignFirstResponder()
		//		} else {
		//			// Create a new task
		//			// if we're in the priority section,
		//			// do something different than in the todo section...
		//		}
	}
	
	func textViewShouldReturn(_ textView: UITextView, in cell: UITableViewCell) -> Bool {
		if textView.text.count > 0 {
			
			tableView.performBatchUpdates({
				let newTask = Task(context: Database.context)
				
				switch editingSection {
				case .priorities:
					dayProvider?.day.addToPriorities(newTask)
					tableView.insertRows(at: [IndexPath(row: tableView(tableView, numberOfRowsInSection: 0) - 1, section: 0)], with: .automatic)
				case .todos:
					dayProvider?.day.addToTodos(newTask)
					tableView.insertRows(at: [IndexPath(row: tableView(tableView, numberOfRowsInSection: 1) - 1, section: 1)], with: .automatic)
				default:
					break
				}
			}, completion: { _ in
				// Start editing the next field
				var indexPath: IndexPath?
				
				switch self.editingSection {
				case .priorities:
					indexPath = IndexPath(row: self.tableView(self.tableView, numberOfRowsInSection: 0), section: 0)
				case .todos:
					indexPath = IndexPath(row: self.tableView(self.tableView, numberOfRowsInSection: 1), section: 1)
				default:
					break
				}
				
				guard let path = indexPath else {
					print("No index path")
					return
				}
				
				let cell = self.tableView.cellForRow(at: path)
				
				if let taskCell = cell as? TaskCell {
					taskCell.textView.becomeFirstResponder()
				}
			})
			return false
		} else {
			editingSection = .none
			textView.resignFirstResponder()
			return true
		}
	}
}
