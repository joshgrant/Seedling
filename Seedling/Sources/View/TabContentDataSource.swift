//
//  TabContentDataSource.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
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
	
	func cellIdentifier(for indexPath: IndexPath) -> String
	{
		preconditionFailure("Implement in subclasses")
	}
}
