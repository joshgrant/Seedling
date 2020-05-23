//
//  TabContentController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/16/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TabContentController: UIViewController
{
	// MARK: - Variables
	
	weak var dayProvider: DayProvider?
	
	let cellClassIdentifiers: [CellClassIdentifier]
	
	let delegate: TabContentDelegate
	let dataSource: TabContentDataSource
	
	let tableView: UITableView
	
	// MARK: - Initialization
	
	init?(dayProvider: DayProvider)
	{
		// 1. self assignments
		self.dayProvider = dayProvider
		
		// 2. Factory
		cellClassIdentifiers = Self.makeCellClassIdentifiers()
		delegate = Self.makeDelegate()
		dataSource = Self.makeDataSource(dayProvider: dayProvider)
		tableView = Self.makeTableView()
		
		// 3. Super init
		super.init(coder: Coder())
		
		// 4. Super assignments
		tabBarItem = Self.makeTabBarItem()
		
		// 5. Configuration
		configureDelegate()
		configureDataSource()
		configureTableView()
		configureView()
		
		// 6. Notifications
		registerNotifications()
	}
	
	required init?(coder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Factory
	
	class func makeDelegate() -> TabContentDelegate
	{
		return TabContentDelegate()
	}
	
	class func makeDataSource(dayProvider: DayProvider) -> TabContentDataSource
	{
		return TabContentDataSource(dayProvider: dayProvider)
	}
	
	class func makeTableView() -> UITableView
	{
		return UITableView()
	}
	
	class func makeCellClassIdentifiers() -> [CellClassIdentifier]
	{
		return [
			.init(cellClass: UITableViewCell.self, cellReuseIdentifier: "cell")
		]
	}
	
	class func makeTabBarItem() -> UITabBarItem
	{
		preconditionFailure("Override this method in your subclasses")
	}
	
	// MARK: - Configuration
	
	func configureDelegate()
	{
		
	}
	
	func configureDataSource()
	{
		
	}
	
	func configureTableView()
	{
		tableView.backgroundColor = .white
		tableView.separatorStyle = .none
		
		cellClassIdentifiers.forEach { identifier in
			tableView.register(identifier.cellClass, forCellReuseIdentifier: identifier.cellReuseIdentifier)
		}
		
		tableView.dataSource = dataSource
		tableView.delegate = delegate
	}
	
	func configureView()
	{
		view = tableView
	}
	
	func configureNavigationItemTitle()
	{
		let formatter = DateFormatter()
		formatter.dateStyle = .short
		
		guard let day = dayProvider?.day else {
			tabBarController?.navigationItem.title = "None"
			return
		}
		
		let todayPredicate = Date().makeDayPredicate()
		let isToday = todayPredicate.evaluate(with: day)
		
		if isToday  {
			let title = "Today"
			tabBarController?.navigationItem.title = title
		} else {
			let title = formatter.string(from: day.date ?? Date())
			tabBarController?.navigationItem.title = title
		}
	}
}

// MARK: - Notifications

extension TabContentController
{
	var notifySelectors: [NotifySelector]
	{
		return [
			.init(name: .dayProviderDidUpdateDay, selector: #selector(self.dayProviderDidUpdateDay(_:))),
			.init(name: UIResponder.keyboardWillChangeFrameNotification, selector: #selector(self.keyboardWillChangeFrame(_:)))
		]
	}
	
	func registerNotifications()
	{
		notifySelectors.forEach {
			NotificationCenter.default.addObserver(
				self,
				selector: $0.selector,
				name: $0.name,
				object: nil)
		}
	}
	
	@objc func dayProviderDidUpdateDay(_ notification: Notification)
	{
		configureNavigationItemTitle()
		tableView.reloadData()
	}
	
	@objc func keyboardWillChangeFrame(_ notification: Notification)
	{
		guard let keyboard = KeyboardNotification(notification: notification) else
		{
			fatalError()
		}
		
		print(keyboard)
		
		// 22 is the footer for the bottom section...
		let frameInView = view.convert(keyboard.frameEnd, from: nil)
		let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame.insetBy(dx: 0, dy: -additionalSafeAreaInsets.bottom - 22)
		let intersection = safeAreaFrame.intersection(frameInView)
		
		UIViewPropertyAnimator(
			duration: keyboard.duration,
			curve: keyboard.animationCurve) {
				self.additionalSafeAreaInsets.bottom = intersection.height
				self.view.layoutIfNeeded()
		}.startAnimation()
	}
}
