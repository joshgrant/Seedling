//
//  TabContentController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/16/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TabContentDataSource: NSObject, UITableViewDataSource {
	
}

class TabContentDelegate: NSObject, UITableViewDelegate {
	
}

class TabContentController: UIViewController
{
	// MARK: - Variables
	
	weak var dayProvider: DayProvider?
	
	let delegate: TabContentDelegate
	let dataSource: TabContentDataSource
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
		
		handleNotifications()
	}
	
	required init?(coder: NSCoder = Coder()) { super.init(coder: coder) }
	
	// MARK: - Factory methods
	
	static func makeTableView() -> UITableView
	{
		return UITableView()
	}
	
	static func makeTabBarItem() -> UITabBarItem
	{
		preconditionFailure("Override this method in your subclasses")
	}
	
	// MARK: - Configuration
	
	func configureView() {
		view = tableView
	}
	
	func configureTableView()
	{
		tableView.backgroundColor = .white
		tableView.separatorStyle = .none
		//		tableView.keyboardDismissMode = .interactive
		
		tableView.register(TaskCell.self, forCellReuseIdentifier: "taskCell")
		
		tableView.dataSource = self
		tableView.delegate = self
	}
	
	// MARK: - Notifications
}
