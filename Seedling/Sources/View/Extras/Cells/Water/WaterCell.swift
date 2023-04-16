//
//  WaterCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class WaterCell: UITableViewCell
{
	// MARK: - Initialization
	
	var water: Water?
	
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
	{
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let leftPadding = UIView()
        let rightPadding = UIView()
        
        let vStack = UIStackView(arrangedSubviews: [
			makeStackView(tag: 1),
			makeStackView(tag: 7) // Number of horizontal items from above...
        ])
        vStack.axis = .vertical
        vStack.spacing = 15
        
        let hStack = UIStackView(arrangedSubviews: [
            leftPadding,
            vStack,
            rightPadding
        ])
        
        // Add these after added to parent view
        rightPadding.widthAnchor.constraint(equalTo: leftPadding.widthAnchor).isActive = true
        
        contentView.embed(view: hStack)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
	
	// MARK: - Factories
    
	func makeStackView(tag: Int) -> UIStackView
	{
        let stackView = UIStackView(arrangedSubviews: [
            makeButton(tag: tag + 0),
            makeButton(tag: tag + 1),
            makeButton(tag: tag + 2),
            makeButton(tag: tag + 3),
            makeButton(tag: tag + 4),
            makeButton(tag: tag + 5),
        ])
        stackView.spacing = 15
        return stackView
    }
    
	func makeButton(tag: Int) -> UIButton
	{
        let button = UIButton()
        button.setImage(SeedlingAsset.clearBubble.image, for: .normal)
        button.addTarget(self, action: #selector(didTouchUpInsideBubble(_:)), for: .touchUpInside)
        // Why is the selector crossed out?
		button.tag = tag
        
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40),
        ])
		
		button.isEnabled = tag == 1
		
        return button
    }
	
	// MARK: - Actions
    
	// TODO: Needs some cleanup. There's probably a better approach
	// Also duplicated in the pomodoro cell
    @objc func didTouchUpInsideBubble(_ sender: UIButton)
	{
		// If we tap on one that's filled, we subtract
		if Int32(sender.tag) == water?.amount
        {
			water?.amount -= 1
			
            sender.setImage(SeedlingAsset.clearBubble.image, for: .normal)
			
			let tag = sender.tag
			let next = tag + 1
			let nextButton = viewWithTag(next) as? UIButton
			
			nextButton?.isEnabled = false
		}
        else if Int32(sender.tag) == (water?.amount ?? 0) + 1
        {
            sender.setImage(SeedlingAsset.blueBubble.image, for: .normal)
			
			water?.amount = Int32(sender.tag)
			
			let tag = sender.tag
			let next = tag + 1
		
			let nextButton = viewWithTag(next) as? UIButton
		
			nextButton?.isEnabled = true
		}
    }
	
	// MARK: - Configuration
	
	func configure(with water: Water)
	{
		self.water = water
		
		let amount = Int(water.amount) + 1
		let numberOfWater = 12 + 1
		for i in 1 ..< numberOfWater
        {
			let button = viewWithTag(i) as? UIButton
			if i < amount
            {
                button?.setImage(SeedlingAsset.blueBubble.image, for: .normal)
				button?.isEnabled = true
			}
            else if i == amount
            {
				button?.isEnabled = true
                button?.setImage(SeedlingAsset.clearBubble.image, for: .normal)
			}
            else
            {
				button?.isEnabled = false
				button?.setImage(SeedlingAsset.clearBubble.image, for: .normal)
			}
		}
	}
}
