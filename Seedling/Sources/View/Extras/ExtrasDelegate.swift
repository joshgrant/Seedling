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
	override func titleForHeader(in section: Int) -> String?
	{
		switch section
		{
		case 0:
            return SeedlingStrings.meals.localizedCapitalized
		case 1:
            return SeedlingStrings.water.localizedCapitalized
		case 2:
            return SeedlingStrings.pomodoro.localizedCapitalized
		case 3:
            return SeedlingStrings.notes.localizedCapitalized
		default:
			return nil
		}
	}
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        switch section
        {
        case 4:
            return nil
        default:
            return super.tableView(tableView, viewForHeaderInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        switch section
        {
        case 4:
            return 0
        default:
            return super.tableView(tableView, heightForHeaderInSection: section)
        }
    }
}

// MARK: - Scroll view delegate

extension ExtrasDelegate
{
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
	{
		scrollView.endEditing(false)
	}
}
