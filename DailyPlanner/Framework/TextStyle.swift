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
    
    var textColor: UIColor {
        switch self {
        case .textView:
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
        case .textView:
            return 17
        default:
            return 10
        }
    }
    
    var font: UIFont {
        switch self {
        case .textView:
            return .monospacedSystemFont(ofSize: fontSize, weight: .regular)
        default:
            return .monospacedSystemFont(ofSize: fontSize, weight: .bold)
        }
    }
}