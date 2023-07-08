//
//  TextField.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TextField: UITextField
{
    var padding: UIEdgeInsets = {
        // TODO: This padding is arbirtrary
        // and the idea is that the text field will be the
        // size of a UITableViewCell
        UIEdgeInsets(top: 11, left: 15, bottom: 11, right: 11)
    }()

    override func editingRect(forBounds bounds: CGRect) -> CGRect
    {
        CGRect(x: bounds.origin.x + padding.left,
               y: bounds.origin.y + padding.top,
               width: bounds.size.width - (padding.left + padding.right),
               height: bounds.size.height - (padding.top + padding.bottom))
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect
    {
        editingRect(forBounds: bounds)
    }
}
