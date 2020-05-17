//
//  Spacer.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class Spacer: UIView
{
	// MARK: - Initialization
	
	init(width: CGFloat? = nil, height: CGFloat? = nil)
	{
		super.init(coder: Coder())!
		
		var widthConstraint: NSLayoutConstraint?
		var heightConstraint: NSLayoutConstraint?
		
		// Width
		
		if let width = width
		{
			widthConstraint = widthAnchor.constraint(equalToConstant: width)
		}
		
		if let widthConstraint = widthConstraint
		{
			NSLayoutConstraint.activate([
				widthConstraint
			])
		}
		else
		{
			setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		}
		
		// Height
		
		if let height = height
		{
			heightConstraint = heightAnchor.constraint(equalToConstant: height)
		}
		
		if let heightConstraint = heightConstraint
		{
			NSLayoutConstraint.activate([
				heightConstraint
			])
		}
		else
		{
			setContentCompressionResistancePriority(.defaultLow, for: .vertical)
		}
	}
	
	required init?(coder: NSCoder = Coder())
	{
		super.init(coder: coder)
	}
}
