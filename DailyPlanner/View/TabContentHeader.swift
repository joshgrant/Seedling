//
//  TabContentHeader.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TabContentHeader: UIView
{
	// MARK: - Variables
	
	var content: String
	
	let label: UILabel
	let visualEffectView: UIVisualEffectView
	let stackView: UIStackView
	
	// MARK: - Initialization
	
	required init?(content: String)
	{
		self.content = content
		
		label = Self.makeLabel()
		visualEffectView = Self.makeVisualEffectView()
		stackView = Self.makeStackView()
		
		super.init(coder: Coder())
		
		configureStackView()
		configureVisualEffectView()
		configureView()
	}
	
	required init?(coder: NSCoder = Coder())
	{
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Factory
	
	class func makeLabel() -> UILabel
	{
		return UILabel(style: .sectionHeader)
	}
	
	private class func makeBlurEffect() -> UIBlurEffect
	{
		let style = UIBlurEffect.Style.regular
		return UIBlurEffect(style: style)
	}
	
	class func makeVisualEffectView() -> UIVisualEffectView
	{
		let blurEffect = makeBlurEffect()
		let visualEffectView = UIVisualEffectView(effect: blurEffect)
		return visualEffectView
	}
	
	class func makeStackView() -> UIStackView
	{
		return UIStackView()
	}
	
	// MARK: - Configuration
	
	func configureView()
	{
		embed(view: visualEffectView)
	}
	
	func configureVisualEffectView()
	{
		visualEffectView.contentView.embed(view: stackView)
	}
	
	func configureStackView()
	{
		stackView.addArrangedSubview(Spacer(width: 10))
		stackView.addArrangedSubview(label)
	}
}
