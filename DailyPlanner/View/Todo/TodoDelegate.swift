//
//  TodoDelegate.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

protocol TodoDismissalDelegate {
    func shouldStopEditing()
}

class TodoDelegate: TabContentDelegate
{
	// MARK: - Variables
	
	// TODO: I think we should use a delegate to notify the controller
	// rather than passing these values
    weak var database: Database?
	weak var dayProvider: DayProvider?
	weak var tableView: UITableView?
    
    var editingIndexPath: IndexPath?
	
	// MARK: - Factory
	
	class func makeButton() -> UIButton
	{
		let button = UIButton(type: .contactAdd)
		button.tintColor = .type(.orange)
		return button
	}
	
	// MARK: - Configuration
	
	func configureButton(button: UIButton)
	{
		button.addTarget(
			self,
			action: #selector(self.didTouchUpInsideButton(_:)),
			for: .touchUpInside)
	}
	
	// MARK: - Selectors
	
	@objc func didTouchUpInsideButton(_ sender: UIButton)
	{
		let section = sender.tag - 1
		
		switch section
		{
		case 0:
			tableView?.performBatchUpdates({
				let priorityCount = dayProvider?.day.prioritiesArray.count
                let priority = Task.make(content: "", in: database!.context)
				dayProvider?.day.addToPriorities(priority)
                let indexPath = IndexPath(item: priorityCount ?? 0, section: 0)
				tableView?.insertRows(at: [indexPath], with: .automatic)
                editingIndexPath = indexPath
			}, completion: { _ in
                self.database?.save()
			})
		case 1:
			tableView?.performBatchUpdates({
				let todoCount = dayProvider?.day.todosArray.count // It matters when we create this variable
                let todo = Task.make(content: "", in: database!.context)
				dayProvider?.day.addToTodos(todo)
                let indexPath = IndexPath(item: todoCount ?? 0, section: 1)
				tableView?.insertRows(at: [indexPath], with: .automatic)
                // Start editing the last row...
                editingIndexPath = indexPath
			}, completion: { _ in
                self.database?.save()
			})
		default:
			break
		}
	}
	
	// MARK: - Table view delegate
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
	{
		let content = titleForHeader(in: section)
		let button = Self.makeButton()
		button.tag = section + 1
        button.accessibilityLabel = content
        button.accessibilityIdentifier = accessibilityIdentifierForAddButton(in: section)
		configureButton(button: button)
		
		let view = TabContentHeader(content: content, button: button)
		return view
	}
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath == editingIndexPath
        {
            if let cell = cell as? TaskCell {
                cell.textView.becomeFirstResponder()
            }
        }
    }
	
	override func titleForHeader(in section: Int) -> String?
	{
		switch section
		{
		case 0:
			return "Priorities"
		case 1:
			return "To Do"
		default:
			return nil
		}
	}
    
    func accessibilityIdentifierForAddButton(in section: Int) -> String?
    {
        switch section
        {
        case 0:
            return "add.priority"
        case 1:
            return "add.todo"
        default:
            return nil
        }
    }
}

// MARK: - Scroll view delegate

extension TodoDelegate
{
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
	{
		scrollView.endEditing(false)
        shouldStopEditing()
	}
}

extension TodoDelegate: TodoDismissalDelegate {
    func shouldStopEditing() {
        print("Setting to nil")
        editingIndexPath = nil
    }
}
