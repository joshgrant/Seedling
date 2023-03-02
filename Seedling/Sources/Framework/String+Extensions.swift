//
//  String+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

extension String {
    
    func height(with style: TextStyle, constrainedTo width: CGFloat) -> CGFloat {
        
        let size = CGSize(width: width - style.horizontalPadding * 2, height: .greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        let attributes = [NSAttributedString.Key.font : style.font]
        
        let boundingRect = NSString(string: self).boundingRect(
            with: size,
            options: options,
            attributes: attributes,
            context: nil)
        
        return ceil(boundingRect.size.height + style.verticalPadding * 2)
    }
}
