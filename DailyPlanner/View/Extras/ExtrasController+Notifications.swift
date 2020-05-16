//
//  ExtrasController+Notifications.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/16/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import Foundation

extension ExtrasController
{
	func handleNotifications()
	{
		NotificationCenter.default.addObserver(
			self, selector: #selector(dayProviderDidUpdateDay(_:)),
			name: .dayProviderDidUpdateDay,
			object: nil)
	}
	
	@objc func dayProviderDidUpdateDay(_ notification: Notification)
	{
		tableView.reloadData()
	}
}
