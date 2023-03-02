//
//  UIImage+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

extension UIImage
{
	enum Image: String
	{
		case blueBubble
		case clearBubble
		case orangeBubble
		
		case todo
		case todoSelected
		
		case extras
		case extrasSelected
		
		case clock
		case clockSelected
	}
	
	static func type(_ type: Image) -> UIImage {
		return UIImage(named: type.rawValue)!
	}
}
