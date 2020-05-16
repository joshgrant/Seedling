//
//  TodoController+Delegate.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

extension TodoController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let label = UILabel()
		label.font = UIFont.monospacedSystemFont(ofSize: 20, weight: .regular)
		label.textColor = UIColor(named: "orange")
		label.textAlignment = .center
		
		switch section {
		case 0:
			label.text = "Priorities"
		case 1:
			label.text = "Todos"
		default:
			break
		}
		
		let leftSpacer = UIView()
		leftSpacer.widthAnchor.constraint(equalToConstant: 20).isActive = true
		
		let rightSpacer = UIView()
		rightSpacer.widthAnchor.constraint(equalToConstant: 20).isActive = true
		
		let button = UIButton(type: .contactAdd)
		button.tag = section + 1
		button.addTarget(self, action: #selector(didTouchUpInsideAddButton(_:)), for: .touchUpInside)
		button.tintColor = .type(.orange)
		
		let vStack = UIStackView(arrangedSubviews: [leftSpacer, label, UIView(), button, rightSpacer])
		vStack.axis = .horizontal
		
		let effect = UIBlurEffect(style: .regular)
		let visualEffectsView = UIVisualEffectView(effect: effect)
		
		visualEffectsView.contentView.embed(view: vStack)
		
		return visualEffectsView
	}
	
	@objc func didTouchUpInsideAddButton(_ sender: UIButton) {
		let section = sender.tag - 1
		
		if section == 0 {
			tableView.performBatchUpdates({
				let priorityCount = dayProvider?.day.prioritiesArray.count
				let priority = Task.make(content: "")
				dayProvider?.day.addToPriorities(priority)
				tableView.insertRows(at: [IndexPath(item: priorityCount ?? 0, section: 0)], with: .automatic)
			}, completion: { _ in
				Database.save()
			})
		} else if section == 1 {
			tableView.performBatchUpdates({
				let todoCount = dayProvider?.day.todosArray.count // It matters when we create this variable
				let todo = Task.make(content: "")
				dayProvider?.day.addToTodos(todo)
				tableView.insertRows(at: [IndexPath(item: todoCount ?? 0, section: 1)], with: .automatic)
			}, completion: { _ in
				Database.save()
			})
		}
	}

	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		switch editingStyle {
		case .delete:
			switch Section(rawValue: indexPath.section) {
			case .priorities:
				if let task = dayProvider?.day.prioritiesArray[indexPath.row] {
					tableView.performBatchUpdates({
						dayProvider?.day.removeFromPriorities(task)
						Database.context.delete(task)
						tableView.deleteRows(at: [indexPath], with: .automatic)
					}, completion: { _ in
						Database.save()
					})
				}
			case .todos:
				if let task = dayProvider?.day.todosArray[indexPath.row] {
					tableView.performBatchUpdates({
						dayProvider?.day.removeFromTodos(task)
						Database.context.delete(task)
						tableView.deleteRows(at: [indexPath], with: .automatic)
					}, completion: { _ in
						Database.save()
					})
				}
			case .none:
				break
			}
		default:
			break
		}
	}
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		view.endEditing(false)
	}
}
