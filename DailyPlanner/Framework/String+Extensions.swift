//
//  String+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

enum TextStyle {
    case textView
}

extension String {
    
    func height(with style: TextStyle, constrainedTo width: CGFloat) -> CGFloat {
        
        let verticalPadding: CGFloat
        let horizontalPadding: CGFloat
        let fontSize: CGFloat
        let font: UIFont
        
        switch style {
        case .textView:
            verticalPadding = 12
            horizontalPadding = 10
            fontSize = 17
            font = .monospacedSystemFont(ofSize: fontSize, weight: .regular)
        }
        
        let size = CGSize(width: width - horizontalPadding * 2, height: .greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        let attributes = [NSAttributedString.Key.font : font]
        
        let boundingRect = NSString(string: self).boundingRect(
            with: size,
            options: options,
            attributes: attributes,
            context: nil)
        
        return ceil(boundingRect.size.height + verticalPadding * 2)
    }
}
