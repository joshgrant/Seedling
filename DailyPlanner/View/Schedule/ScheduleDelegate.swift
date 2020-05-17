//
//  ScheduleDelegate.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class ScheduleDelegate: TabContentDelegate
{
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
	{
		scrollView.endEditing(false)
	}
}
