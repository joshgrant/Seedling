//
//  TextStyle.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

enum TextStyle {
    
    case textView
    case sectionHeader
    case hour
    case meridiem
	case meals
    
    var textColor: UIColor {
        switch self {
		case .textView, .meals:
			return .type(.text)
        default:
			return .type(.orange)
        }
    }
    
    var verticalPadding: CGFloat {
        switch self {
        case .textView:
            return 12
        default:
            return 0
        }
    }
    
    var horizontalPadding: CGFloat {
        switch self {
        case .textView:
            return 10
        default:
            return 0
        }
    }
    
    var fontSize: CGFloat {
        switch self {
		case .textView, .meals:
            return 17
		case .sectionHeader:
			return 20
		case .meridiem, .hour:
			return 15
        default:
            return 10
        }
    }
    
    var font: UIFont {
		return .monospacedSystemFont(ofSize: fontSize, weight: .regular)
    }
}
