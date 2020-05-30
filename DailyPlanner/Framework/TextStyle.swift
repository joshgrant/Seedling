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
	case mealHeader
    case mealContent
    case navigationBar
    
    var textColor: UIColor {
        switch self {
        case .textView, .mealHeader, .navigationBar:
			return .type(.text)
        case .mealContent:
            return .type(.emerald)
        default:
			return .type(.orange)
        }
    }
    
    var verticalPadding: CGFloat {
        switch self {
        case .textView, .mealContent:
            return 12
        default:
            return 0
        }
    }
    
    var horizontalPadding: CGFloat {
        switch self {
        case .textView, .mealContent:
            return 10
        default:
            return 0
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .textView, .mealHeader, .mealContent:
            return 17
		case .sectionHeader:
			return 20
        case .navigationBar:
            return 22
		case .meridiem, .hour:
			return 15
        }
    }
    
    var font: UIFont {
        let font = UIFont.monospacedSystemFont(ofSize: fontSize, weight: .regular)
        
        switch fontSize {
        case ...16:
            return UIFontMetrics(forTextStyle: .callout).scaledFont(for: font)
        case 17...:
            return UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
        default:
            return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        }
    }
}
