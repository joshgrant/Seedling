//
//  TodoController+CellTextViewDelegate.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

extension TodoController: CellTextViewDelegate
{
	func textViewDidBeginEditing(_ textView: UITextView, in cell: UITableViewCell)
	{
		let indexPath = tableView.indexPath(for: cell)
		editingSection = Section(rawValue: indexPath?.section ?? 0)
	}
	
	func textViewDidChange(_ textView: UITextView, in cell: UITableViewCell)
	{
		tableView.performBatchUpdates({
			UIView.animate(withDuration: 0.0) {
				cell.contentView.setNeedsLayout()
				cell.contentView.layoutIfNeeded()
			}
		}, completion: nil)
	}
	
	func textViewDidEndEditing(_ textView: UITextView, in cell: UITableViewCell)
	{
	}
	
	func textViewShouldReturn(_ textView: UITextView, in cell: UITableViewCell) -> Bool
	{
		if textView.text.count > 0
		{
			tableView.performBatchUpdates({
				let newTask = Task(context: Database.context)
				
				switch editingSection {
				case .priorities:
					let rowToInsert = dayProvider?.day.prioritiesArray.count ?? 0
					dayProvider?.day.addToPriorities(newTask)
					tableView.insertRows(at: [IndexPath(row: rowToInsert, section: 0)], with: .automatic)
				case .todos:
					let rowToInsert = dayProvider?.day.todosArray.count ?? 0
					dayProvider?.day.addToTodos(newTask)
					tableView.insertRows(at: [IndexPath(row: rowToInsert, section: 1)], with: .automatic)
				default:
					break
				}
			}, completion: { _ in
				// Start editing the next field
				var indexPath: IndexPath?
				
				switch self.editingSection
				{
				case .priorities:
					indexPath = IndexPath(row: (self.dayProvider?.day.prioritiesArray.count ?? 0) - 1, section: 0)
				case .todos:
					indexPath = IndexPath(row: (self.dayProvider?.day.todosArray.count ?? 0) - 1, section: 1)
				default:
					break
				}
				
				guard let path = indexPath else
				{
					print("No index path")
					return
				}
				
				let cell = self.tableView.cellForRow(at: path)
				
				if let taskCell = cell as? TaskCell
				{
					taskCell.textView.becomeFirstResponder()
				}
			})
		}
		else
		{
			tableView.performBatchUpdates({
				switch self.editingSection
				{
				case .priorities:
					if let priority = self.dayProvider?.day.prioritiesArray.last
					{
						let indexPath = IndexPath(row: (self.dayProvider?.day.prioritiesArray.count ?? 0) - 1, section: 0)
						self.dayProvider?.day.removeFromPriorities(priority)
						Database.context.delete(priority)
						self.tableView.deleteRows(at: [indexPath], with: .automatic)
					}
				case .todos:
					if let todo = self.dayProvider?.day.todosArray.last
					{
						let indexPath = IndexPath(row: (self.dayProvider?.day.todosArray.count ?? 0) - 1, section: 1)
						self.dayProvider?.day.removeFromTodos(todo)
						Database.context.delete(todo)
						self.tableView.deleteRows(at: [indexPath], with: .automatic)
					}
				default:
					break
				}
			}, completion: { _ in
				self.editingSection = .none
				textView.resignFirstResponder()
				Database.save()
			})
		}
		return true
	}
}
