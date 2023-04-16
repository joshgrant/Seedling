//
//  PomodoroCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class PomodoroCell: UITableViewCell
{
	var pomodoro: Pomodoro?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let leftPadding = UIView()
        let rightPadding = UIView()
        
        let vStack = UIStackView(arrangedSubviews: [
			// The tags need to start at 1 because
			// everything has a tag of 0
            makeStackView(tag: 1),
            makeStackView(tag: 5),
			makeStackView(tag: 9),
			makeStackView(tag: 13)
        ])
        vStack.spacing = 12
        vStack.axis = .vertical
        
        let hStack = UIStackView(arrangedSubviews: [
            leftPadding,
            vStack,
            rightPadding
        ])
        
        leftPadding.widthAnchor.constraint(equalTo: rightPadding.widthAnchor).isActive = true
        
        contentView.embed(view: hStack)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
	func makeButton(tag: Int) -> UIButton
    {
        let button = UIButton()
        button.setImage(UIImage(named: "clearBubble"), for: .normal)
        button.addTarget(self, action: #selector(didTouchUpInsideBubble(_:)), for: .touchUpInside)
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

	// TODO: Needs some cleanup. There's probably a better approach
	@objc func didTouchUpInsideBubble(_ sender: UIButton)
	{
		// If we tap on one that's filled, we subtract
		if Int32(sender.tag) == pomodoro?.amount
        {
			pomodoro?.amount -= 1
			
            sender.setImage(SeedlingAsset.clearBubble.image, for: .normal)
			
			let tag = sender.tag
			let next = tag + 1
			let nextButton = viewWithTag(next) as? UIButton
			
			nextButton?.isEnabled = false
		}
        else if Int32(sender.tag) == (pomodoro?.amount ?? 0) + 1
        {
            sender.setImage(SeedlingAsset.orangeBubble.image, for: .normal)
			
			pomodoro?.amount = Int32(sender.tag)
			
			let tag = sender.tag
			let next = tag + 1
			
			let nextButton = viewWithTag(next) as? UIButton
			
			nextButton?.isEnabled = true
		}
	}
    
	func makeStackView(tag: Int) -> UIStackView
    {
        let stackView = UIStackView(arrangedSubviews: [
			makeButton(tag: tag + 0),
            makeButton(tag: tag + 1),
            makeButton(tag: tag + 2),
            makeButton(tag: tag + 3),
        ])
        stackView.spacing = 10
        return stackView
    }
	
	// MARK: - Configuration
	
	func configure(with pomodoro: Pomodoro)
	{
		self.pomodoro = pomodoro
		
		let amount = Int(pomodoro.amount) + 1
		let numberOfPomodoro = 16 + 1
		for i in 1 ..< numberOfPomodoro
        {
			let button = viewWithTag(i) as? UIButton
			if i < amount
            {
                button?.setImage(SeedlingAsset.orangeBubble.image, for: .normal)
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
