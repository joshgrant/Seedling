//
//  TodoController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TodoController: UIViewController
{
	// MARK: - Variables
	
	enum Section: Int {
		case priorities
		case todos
	}
    
	weak var dayProvider: DayProvider?
	
    let tableView: UITableView
	
	var editingSection: Section?
	
	// MARK: - Initialization
    
    init?(dayProvider: DayProvider)
	{
        self.dayProvider = dayProvider
        
		tableView = Self.makeTableView()
		
        super.init(coder: Coder())
		
		tabBarItem = Self.makeTabBarItem()
		
		configureView()
		configureTableView()
		
        handleNotifications()
    }
    
    required init?(coder: NSCoder) { fatalError() }
	
	// MARK: - Factories
	
	private static func makeTableView() -> UITableView
	{
		return UITableView(frame: .zero, style: .grouped)
	}
	
	private static func makeTabBarItem() -> UITabBarItem
	{
		//        tabBarItem.landscapeImagePhone = UIImage(named: "todoCompact")
		// Good for accessibility
		//        tabBarItem.largeContentSizeImage
		return UITabBarItem(
			title: "To do",
			image: .type(.todo),
			selectedImage: .type(.todoSelected))
	}
	
	// MARK: - Configuration
	
	private func configureView() {
		view = tableView
	}
	
	private func configureTableView()
	{
		tableView.backgroundColor = .white
		tableView.separatorStyle = .none
		tableView.keyboardDismissMode = .interactive
		
		tableView.register(TaskCell.self, forCellReuseIdentifier: "taskCell")
		
		tableView.dataSource = self
		tableView.delegate = self
	}
}
