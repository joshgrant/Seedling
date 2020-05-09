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
		
		let vStack = UIStackView(arrangedSubviews: [UIView(), label])
		vStack.axis = .vertical
		
		return vStack
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
}
