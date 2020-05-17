//
//  TabContentController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/16/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TabContentDataSource: NSObject, UITableViewDataSource
{
	// MARK: - Variables
	
	weak var dayProvider: DayProvider?
	
	// MARK: - Initialization
	
	init(dayProvider: DayProvider)
	{
		self.dayProvider = dayProvider
	}
	
	// MARK: - Data source
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		preconditionFailure("Implement in subclasses")
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		preconditionFailure("Implement in subclasses")
	}
	
	// MARK: - Glue
	
	func cellIdentifier(for indexPath: IndexPath) -> String
	{
		switch indexPath.section
		{
		case 0:
			return "mealsCell"
		case 1:
			return "waterCell"
		case 2:
			return "pomodoroCell"
		case 3:
			return "notesCell"
		default:
			return "cell"
		}
	}
}

class TabContentDelegate: NSObject, UITableViewDelegate
{
	
}

struct CellClassIdentifier
{
	var cellClass: AnyClass?
	var cellReuseIdentifier: String
}

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
	
	required init?(coder: NSCoder) {
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
}

// MARK: - Notifications

struct NotifySelector
{
	var name: Notification.Name
	var selector: Selector
}

struct KeyboardNotification
{
	var duration: TimeInterval
	var animationCurve: UIView.AnimationCurve
	
	var frameBegin: CGRect
	var frameEnd: CGRect
	
	var isLocal: Bool
	
	init?(notification: Notification)
	{
		guard let userInfo = notification.userInfo else { return nil }
		
		if let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
		{
			self.duration = duration
		}
		else
		{
			return nil
		}
		
		if let curveRaw = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue, let animationCurve = UIView.AnimationCurve(rawValue: curveRaw)
		{
			self.animationCurve = animationCurve
		}
		else
		{
			return nil
		}
		
		if let frameBegin = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect
		{
			self.frameBegin = frameBegin
		}
		else
		{
			return nil
		}
		
		if let frameEnd = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
		{
			self.frameEnd = frameEnd
		}
		else
		{
			return nil
		}
		
		if let isLocal = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? Bool
		{
			self.isLocal = isLocal
		}
		else
		{
			return nil
		}
	}
}

extension KeyboardNotification: CustomStringConvertible
{
	var description: String
	{
		return "Duration: \(duration), Curve: \(animationCurve.rawValue)\n"
			+ "Begin: \(frameBegin), End: \(frameEnd)"
			+ "isLocal: \(isLocal)"
	}
}

extension TabContentController
{
	var notifySelectors: [NotifySelector] {
		return [
			.init(name: .dayProviderDidUpdateDay, selector: #selector(self.dayProviderDidUpdateDay(_:))),
			.init(name: UIResponder.keyboardWillShowNotification, selector: #selector(self.keyboardWillShow(_:))),
			.init(name: UIResponder.keyboardWillHideNotification, selector: #selector(self.keyboardWillHide(_:))),
			.init(name: UIResponder.keyboardWillChangeFrameNotification, selector: #selector(self.keyboardWillChangeFrame(_:)))
		]
	}
	
	func registerNotifications() {
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
		tableView.reloadData()
	}
	
	@objc func keyboardWillShow(_ notification: Notification)
	{
		guard let keyboard = KeyboardNotification(notification: notification) else
		{
			fatalError()
		}
		
		print(keyboard)
		
//		UIViewPropertyAnimator(
//			duration: keyboard.duration,
//			curve: keyboard.animationCurve) {
//				let bottomInset = keyboard.frameEnd.height
//				self.tableView.contentInset.bottom = bottomInset
//				self.tableView.verticalScrollIndicatorInsets.bottom = bottomInset
//		}.startAnimation()
	}
	
	@objc func keyboardWillHide(_ notification: Notification)
	{
		guard let keyboard = KeyboardNotification(notification: notification) else
		{
			fatalError()
		}
		
		print(keyboard)
		
//		UIViewPropertyAnimator(
//			duration: keyboard.duration,
//			curve: keyboard.animationCurve) {
//				self.tableView.contentInset.bottom = 0
//				self.tableView.verticalScrollIndicatorInsets.bottom = 0
//		}.startAnimation()
	}
	
	@objc func keyboardWillChangeFrame(_ notification: Notification)
	{
		guard let keyboard = KeyboardNotification(notification: notification) else
		{
			fatalError()
		}
		
		print(notification)
		print(keyboard)
		
		let frameInView = view.convert(keyboard.frameEnd, from: nil)
		let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame.insetBy(dx: 0, dy: -additionalSafeAreaInsets.bottom)
		let intersection = safeAreaFrame.intersection(frameInView)
		
		UIViewPropertyAnimator(
			duration: keyboard.duration,
			curve: keyboard.animationCurve) {
				self.additionalSafeAreaInsets.bottom = intersection.height
				self.view.layoutIfNeeded()
		}.startAnimation()
	}
}
