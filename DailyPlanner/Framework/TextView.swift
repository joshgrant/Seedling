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
    var height: NSLayoutConstraint?
	var minimumHeight: NSLayoutConstraint?
    
    override var text: String!
	{
		didSet
		{
			let textHeight = text.height(with: .textView, constrainedTo: frame.width)
			// Unexpectedly found nil when switching tabs
			if let height = height {
				height.constant = textHeight
			} else {
				print("NO HEIGHT")
			}
		}
	}
    
	init(defaultHeight: CGFloat = 44, minimumHeight minimum: CGFloat = 44)
	{
        super.init(coder: Coder())!
		
		isScrollEnabled = false
		
		height = heightAnchor.constraint(equalToConstant: defaultHeight)
		height?.isActive = true
		height?.priority = .defaultLow
		
		minimumHeight = heightAnchor.constraint(greaterThanOrEqualToConstant: minimum)
		minimumHeight?.isActive = true
		minimumHeight?.priority = .defaultHigh
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
        
        
		self.delegate = delegate
    }
}
