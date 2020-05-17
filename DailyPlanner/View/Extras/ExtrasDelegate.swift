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
			return "Meals"
		case 1:
			return "Water"
		case 2:
			return "Pomodoro"
		case 3:
			return "Notes"
		default:
			return nil
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
