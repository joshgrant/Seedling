//
//  TodoDelegate.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TodoDelegate: TabContentDelegate
{
	// MARK: - Variables
	
	// TODO: I think we should use a delegate to notify the controller
	// rather than passing these values
	weak var dayProvider: DayProvider?
	weak var tableView: UITableView?
	
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
				let priority = Task.make(content: "")
				dayProvider?.day.addToPriorities(priority)
				tableView?.insertRows(at: [IndexPath(item: priorityCount ?? 0, section: 0)], with: .automatic)
			}, completion: { _ in
				Database.save()
			})
		case 1:
			tableView?.performBatchUpdates({
				let todoCount = dayProvider?.day.todosArray.count // It matters when we create this variable
				let todo = Task.make(content: "")
				dayProvider?.day.addToTodos(todo)
				tableView?.insertRows(at: [IndexPath(item: todoCount ?? 0, section: 1)], with: .automatic)
			}, completion: { _ in
				Database.save()
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
		configureButton(button: button)
		
		let view = TabContentHeader(content: content, button: button)
		return view
	}
	
	override func titleForHeader(in section: Int) -> String?
	{
		switch section
		{
		case 0:
			return "Priorities"
		case 1:
			return "Todos"
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
	}
}
