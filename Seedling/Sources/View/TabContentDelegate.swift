//
//  TabContentDelegate.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TabContentDelegate: NSObject, UITableViewDelegate
{
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
	{
		54
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
		let content = titleForHeader(in: section)
		let header = TabContentHeader(content: content)
		return header
	}
	
	func titleForHeader(in section: Int) -> String?
	{
		"Implement"
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
	{
        22
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
	{
		return UIView()
	}
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
    {
        22
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
    {
        54
    }
}
