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
        if let indexPath = tableView.indexPath(for: cell) {
            (delegate as? TodoDelegate)?.editingIndexPath = indexPath
        }
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
        guard let indexPath = tableView.indexPath(for: cell) else {
            textView.resignFirstResponder()
            (delegate as? TodoDelegate)?.shouldStopEditing()
            return true
        }
        
        if indexPath.row < tableView.numberOfRows(inSection: indexPath.section) - 1 {
            textView.resignFirstResponder()
            (delegate as? TodoDelegate)?.shouldStopEditing()
            return true
        }
        
		if textView.text.count > 0
		{
			tableView.performBatchUpdates({
                // Any reason we aren't using our own methods?
                let newTask = Task.make(in: database.context)
				
                let editingPath = (delegate as? TodoDelegate)?.editingIndexPath
                
                switch editingPath?.section {
				case 0:
					let rowToInsert = dayProvider.day.prioritiesArray.count
					dayProvider.day.addToPriorities(newTask)
                    let indexPath = IndexPath(row: rowToInsert, section: 0)
					tableView.insertRows(at: [indexPath], with: .automatic)
				case 1:
					let rowToInsert = dayProvider.day.todosArray.count
					dayProvider.day.addToTodos(newTask)
                    let indexPath = IndexPath(row: rowToInsert, section: 1)
					tableView.insertRows(at: [indexPath], with: .automatic)
				default:
					break
				}
			}, completion: { [unowned self] _ in
				// Start editing the next field
				var indexPath: IndexPath?
                
                let editingPath = (self.delegate as? TodoDelegate)?.editingIndexPath
				
                switch editingPath?.section
				{
				case 0:
					indexPath = IndexPath(row: self.dayProvider.day.prioritiesArray.count - 1, section: 0)
				case 1:
					indexPath = IndexPath(row: self.dayProvider.day.todosArray.count - 1, section: 1)
				default:
					break
				}
				
				guard let path = indexPath else
				{
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
            let editingPath = (self.delegate as? TodoDelegate)?.editingIndexPath
            
			tableView.performBatchUpdates({
                
                switch editingPath?.section
				{
				case 0:
					if let priority = self.dayProvider.day.prioritiesArray.last
					{
						let indexPath = IndexPath(row: self.dayProvider.day.prioritiesArray.count - 1, section: 0)
						self.dayProvider.day.removeFromPriorities(priority)
                        self.database.context.delete(priority)
						self.tableView.deleteRows(at: [indexPath], with: .automatic)
					}
				case 1:
					if let todo = self.dayProvider.day.todosArray.last
					{
						let indexPath = IndexPath(row: self.dayProvider.day.todosArray.count - 1, section: 1)
						self.dayProvider.day.removeFromTodos(todo)
                        self.database.context.delete(todo)
						self.tableView.deleteRows(at: [indexPath], with: .automatic)
					}
				default:
					break
				}
			}, completion: { _ in
                (self.delegate as? TodoDelegate)?.editingIndexPath = nil
				textView.resignFirstResponder()
                self.database.save()
			})
		}
		return true
	}
}
