//
//  ScheduleController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class ScheduleController: UIViewController
{
	// MARK: - Variables
	
	weak var dayProvider: DayProvider?
	
    let tableView: UITableView

	// MARK: - Initialization
	
	init?(dayProvider: DayProvider)
	{
		self.dayProvider = dayProvider
		tableView = Self.makeTableView()
		
		super.init(coder: Coder())
		
		tabBarItem = Self.makeTabBarItem()
		configureTableView()
		configureView()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	// MARK: - Factories
	
	static func makeTableView() -> UITableView
	{
		return UITableView()
	}
	
	static func makeTabBarItem() -> UITabBarItem
	{
		return UITabBarItem(
			title: "Schedule",
			image: .type(.clock),
			selectedImage: .type(.clockSelected))
	}
	
	// MARK: - Configuration
	
	func configureTableView()
	{
		tableView.separatorStyle = .none
		tableView.keyboardDismissMode = .onDrag
		
		tableView.register(ScheduleCell.self, forCellReuseIdentifier: "scheduleCell")
		
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	func configureView()
	{
		view = tableView
	}
}

extension ScheduleController: CellTextViewDelegate {
	
	func textViewDidBeginEditing(_ textView: UITextView, in cell: UITableViewCell) {
		//
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
		if let indexPath = tableView.indexPath(for: cell), let schedule = dayProvider?.day.schedulesArray[indexPath.row] {
			schedule.content = textView.text
			Database.save()
		}
		textView.resignFirstResponder()
	}
	
	func textViewShouldReturn(_ textView: UITextView, in cell: UITableViewCell) -> Bool {
		return true
	}
}
