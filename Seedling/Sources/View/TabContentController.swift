//
//  TabContentController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/16/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit
import CoreData

class TabContentController: UIViewController
{
	// MARK: - Variables
    
	unowned var dayProvider: DayProvider
    unowned var database: Database // Not ideal? Perhaps we could have some "configuration" variable like in SwiftUI
	
	let cellClassIdentifiers: [CellClassIdentifier]
	
	var delegate: TabContentDelegate
	let dataSource: TabContentDataSource
	
	let tableView: UITableView
	
	// MARK: - Initialization
	
    init?(dayProvider: DayProvider, database: Database)
	{
		// 1. self assignments
		self.dayProvider = dayProvider
        self.database = database
		
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
	}
	
	required init?(coder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listenForNotifications(true)
        tableView.reloadData()
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		view.endEditing(false)
	}
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        listenForNotifications(false)
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
		tableView.backgroundColor = .systemBackground
		tableView.separatorStyle = .none
		
		cellClassIdentifiers.forEach { identifier in
			tableView.register(identifier.cellClass, forCellReuseIdentifier: identifier.cellReuseIdentifier)
		}
		
		tableView.dataSource = dataSource
		tableView.delegate = delegate
//        tableView.tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: 0, height: .leastNormalMagnitude))
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .leastNormalMagnitude
        }
	}
	
	func configureView()
	{
		view = tableView
	}
	
	func configureNavigationItemTitle()
	{
		let day = dayProvider.day
		
		let todayPredicate = Date().makeDayPredicate()
		let isToday = todayPredicate.evaluate(with: day)
		
		// TODO: The date formatter is not locale-aware
		// so maybe we should update this format...
		
		if isToday  {
			let formatter = DateFormatter()
            formatter.setLocalizedDateFormatFromTemplate(SeedlingStrings.formatDayMonth)
            let title = SeedlingStrings.today(formatter.string(from: day.date ?? Date())).localizedCapitalized
			tabBarController?.navigationItem.title = title
		} else {
			let formatter = DateFormatter()
            formatter.setLocalizedDateFormatFromTemplate(SeedlingStrings.formatWeekdayDayMonth)
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
	
    func listenForNotifications(_ listen: Bool)
	{
        if listen {
            notifySelectors.forEach {
                NotificationCenter.default.addObserver(
                    self,
                    selector: $0.selector,
                    name: $0.name,
                    object: nil)
            }
        } else {
            NotificationCenter.default.removeObserver(self)
        }
	}
	
	@objc func dayProviderDidUpdateDay(_ notification: Notification)
	{
		view.endEditing(false)
		configureNavigationItemTitle()
		tableView.reloadData()
	}
	
	@objc func keyboardWillChangeFrame(_ notification: Notification)
	{
		guard let keyboard = KeyboardNotification(notification: notification) else
		{
			assertionFailure("Failed to get the keyboard information")
            return
		}
		
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
