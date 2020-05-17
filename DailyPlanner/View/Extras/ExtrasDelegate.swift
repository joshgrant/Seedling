//
//  ExtrasDelegate.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class ExtrasDelegate: TabContentDelegate
{
	// MARK: - Variables
	
	/// The view that should resign first responder when scrolled
	weak var view: UIView?
}

// MARK: - Table view delegate

extension ExtrasDelegate
{
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
	{
		return 44
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
	{
		let content = [
			0: "Meals",
			1: "Water",
			2: "Pomodoro",
			3: "Notes"
		][section] ?? ""
		
		let header = TabContentHeader(content: content)
		return header
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
	{
		return 22
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
	{
		return UIView()
	}
}

// MARK: - Scroll view delegate

extension ExtrasDelegate
{
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
	{
		view?.endEditing(false)
	}
}
