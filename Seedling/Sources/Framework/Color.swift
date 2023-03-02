//
//  Color.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

extension UIColor
{
    enum Color: String
    {
        case orange
        case emerald
        case separator
        case text
    }
	
	static func type(_ type: Color) -> UIColor
	{
		return UIColor(named: type.rawValue)!
	}
}
