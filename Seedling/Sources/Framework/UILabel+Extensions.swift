//
//  UILabel+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

extension UILabel
{
	convenience init(style: TextStyle)
	{
		self.init()
		configure(with: style)
	}
	
	func configure(with style: TextStyle)
	{
		font = style.font
		textColor = style.textColor
	}
}
