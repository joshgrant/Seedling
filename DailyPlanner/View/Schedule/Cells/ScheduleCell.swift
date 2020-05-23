//
//  ScheduleCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell
{
	// MARK: - Variables
	
	weak var delegate: CellTextViewDelegate?
	var schedule: Schedule?
    
    let meridiemLabel: UILabel
    let hourLabel: UILabel
    let textView: TextView
	
	let textStack: UIStackView
	let lineStack: UIStackView
	let stack: UIStackView
	
	// MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
	{
		meridiemLabel = Self.makeMeridiemLabel()
		hourLabel = Self.makeHourLabel()
		textView = Self.makeTextView()
		textStack = Self.makeTextStack()
		lineStack = Self.makeLineStack()
		stack = Self.makeStack()
		
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		selectionStyle = .none
		
		// Hmm. With constraints, we need to create the parent
		// views before the children...
		configureContentView()
		configureStack()
		configureTextStack()
		configureLineStack()
		
		configureMeridiemLabel()
		configureHourLabel()
		configureTextView()
    }
    
    required init?(coder: NSCoder)
	{
        fatalError("init(coder:) has not been implemented")
    }
	
	// MARK: - View lifecycle
	
	override func prepareForReuse()
	{
		super.prepareForReuse()
		meridiemLabel.text = nil
		hourLabel.text = nil
		textView.text = nil
		
		delegate = nil
		schedule = nil
	}
	
	// MARK: - Factory
	
	class func makeMeridiemLabel() -> UILabel { return UILabel() }
	class func makeHourLabel() -> UILabel { return UILabel() }
	class func makeTextView() -> TextView { return TextView() }
	class func makeTextStack() -> UIStackView { return UIStackView() }
	class func makeLineStack() -> UIStackView { return UIStackView() }
	class func makeStack() -> UIStackView { return UIStackView() }
	
	// MARK: - Configuration
	
	func configureMeridiemLabel()
	{
		meridiemLabel.configure(with: .meridiem)
		meridiemLabel.setContentHuggingPriority(.required, for: .horizontal)
		
		// Not ideal for other languages
		meridiemLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
	}
	
	func configureHourLabel()
	{
		hourLabel.configure(with: .hour)
		hourLabel.setContentHuggingPriority(.required, for: .horizontal)
	}
	
	func configureTextView()
	{
		textView.configure(with: .textView, delegate: self)
		textView.contentInset = .zero
		textView.isScrollEnabled = false
		textView.textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
		textView.textContainer.lineFragmentPadding = 0
	}
	
	func configureTextStack()
	{
		// TODO: Create a utility function to set the arranged subviews
		// in an easy way (and absolute)
		textStack.addArrangedSubview(Spacer(width: 10))
		textStack.addArrangedSubview(meridiemLabel)
		textStack.addArrangedSubview(Spacer(width: 10))
		textStack.addArrangedSubview(hourLabel)
		textStack.addArrangedSubview(Spacer(width: 7))
		textStack.addArrangedSubview(textView)
	}
	
	func configureLineStack()
	{
		lineStack.addArrangedSubview(Spacer())
		
		let line = Spacer(height: 1)
		lineStack.addArrangedSubview(line) // Lame, but because we need the line and the hour label
		// to be in the view hierarchy before we create a constraint between them
		
		line.backgroundColor = .type(.separator)
		line.leadingAnchor.constraint(equalTo: hourLabel.leadingAnchor).isActive = true
	}
	
	func configureStack()
	{
		stack.addArrangedSubview(textStack)
		stack.addArrangedSubview(lineStack)
		
		stack.axis = .vertical
	}
	
	func configureContentView()
	{
		contentView.embed(view: stack)
	}
    
    func configure(with schedule: Schedule?)
	{
        self.schedule = schedule
		textView.text = schedule?.content
		hourLabel.text = "\(schedule?.hour ?? 0)"
		meridiemLabel.text = meridiemText(for: Int(schedule?.hour ?? 0))
    }
	
	// MARK: - Utility
	
	private func meridiemText(for hour: Int) -> String?
	{
		switch hour
		{
		case 5:
			return "AM"
		case 12:
			return "PM"
		default:
			return nil
		}
	}
}

extension ScheduleCell: UITextViewDelegate
{    
    func textViewDidChange(_ textView: UITextView)
	{
        delegate?.textViewDidChange(textView, in: self)
		self.schedule?.content = textView.text
    }
}
