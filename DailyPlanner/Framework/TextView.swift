//
//  TextView.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TextView: UITextView
{
    var height: NSLayoutConstraint!
    
    override var text: String!
	{
		didSet
		{
			let textHeight = text.height(with: .textView, constrainedTo: frame.width)
			height.constant = textHeight
		}
	}
    
    init()
    {
        super.init(coder: Coder())!
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
	func configure(with style: TextStyle, delegate: UITextViewDelegate)
    {
        font = style.font
        textColor = style.textColor
        contentInset = .zero
        isScrollEnabled = false
        
        textContainerInset = UIEdgeInsets(
            top: style.verticalPadding,
            left: style.horizontalPadding,
            bottom: style.verticalPadding,
            right: style.horizontalPadding)
        
        height = heightAnchor.constraint(equalToConstant: 44)
        height.isActive = true
        height.priority = .defaultLow
        
		self.delegate = delegate
    }
}
