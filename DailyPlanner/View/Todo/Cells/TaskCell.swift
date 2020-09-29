//
//  TaskCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell
{
    let checkBox: UIButton
    let textView: TextView
    
    weak var database: Database?
    weak var delegate: CellTextViewDelegate?
    
    var task: Task?
    var section: TodoController.Section?
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        task = nil
        section = nil
        
        textView.text = nil
        textView.attributedText = nil
		textView.attributedText = nil
		checkBox.imageView?.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        checkBox = UIButton()
        checkBox.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        textView = TextView()
        
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
        textView.textContainer.lineFragmentPadding = 0
        
        let hStack = UIStackView(arrangedSubviews: [checkBox, textView])
        
        let lineSeparator = UIView()
        lineSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
		lineSeparator.backgroundColor = .type(.orange)
        
        let spacer = UIView()
        spacer.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        let hStack2 = UIStackView(arrangedSubviews: [spacer, lineSeparator])
        
        let vStack = UIStackView(arrangedSubviews: [hStack, hStack2])
        vStack.axis = .vertical
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        checkBox.addTarget(self, action: #selector(didTouchUpInsideCheckBox(_:)), for: .touchUpInside)
        
        contentView.embed(view: vStack, bottomPriority: .defaultHigh)
		
		textView.configure(with: .textView, delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with task: Task, section: TodoController.Section) {
        self.task = task
        self.section = section
		
		let content = task.content ?? ""
        
//        textView.text = task.content
//		textView.attributedText = NSAttributedString(string: task.content, attributes: [.stri])
		let textStyle = TextStyle.textView
		let attributedString = NSMutableAttributedString(string: content)
		
		let range = NSRange(location: 0, length: attributedString.length)
		
		attributedString.addAttribute(.font, value: textStyle.font, range: range)
        
        if task.completed {
			checkBox.setImage(.type(.orangeBubble), for: .normal)
			attributedString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)
			attributedString.addAttribute(.strikethroughColor, value: UIColor.placeholderText, range: range)
			attributedString.addAttribute(.foregroundColor, value: UIColor.placeholderText, range: range)
        } else {
			checkBox.setImage(.type(.clearBubble), for: .normal)
			attributedString.addAttribute(.foregroundColor, value: textStyle.textColor, range: range)
        }
		
		textView.attributedText = attributedString
        
        isAccessibilityElement = true
        accessibilityLabel = task.content
        accessibilityTraits = [.adjustable]
        
        switch section {
        case .priorities:
            accessibilityIdentifier = "priority.cell"
        case .todos:
            accessibilityIdentifier = "todo.cell"
        }
        
        textView.accessibilityIdentifier = "todo.textView"
        checkBox.accessibilityIdentifier = "todo.checkBox"
    }
    
    @objc func didTouchUpInsideCheckBox(_ sender: UIButton) {
        
        // Assign the opposite accessibility value
        if task?.completed ?? false {
            sender.accessibilityValue = "Unchecked"
        } else {
            sender.accessibilityValue = "Checked"
        }
        
        database?.context.perform {
            self.task?.completed.toggle()
            if let task = self.task, let section = self.section {
                self.configure(with: task, section: section)
            }
            self.database?.save()
        }
    }
    
    override func accessibilityActivate() -> Bool {
        textView.becomeFirstResponder()
        return true
    }
    
    override func accessibilityIncrement() {
        checkBox.accessibilityValue = "Checked"
        database?.context.perform {
            self.task?.completed = true
            if let task = self.task, let section = self.section {
                self.configure(with: task, section: section)
            }
            self.database?.save()
        }
    }
    
    override func accessibilityDecrement() {
        checkBox.accessibilityValue = "Unchecked"
        database?.context.perform {
            self.task?.completed = false
            if let task = self.task, let section = self.section {
                self.configure(with: task, section: section)
            }
            self.database?.save()
        }
    }
}

extension TaskCell: UITextViewDelegate {
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		delegate?.textViewDidBeginEditing(textView, in: self)
	}
    
    // Not called with programmatic changes, just fyi
    func textViewDidChange(_ textView: UITextView) {
        delegate?.textViewDidChange(textView, in: self)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        database?.context.perform {
            self.task?.content = textView.text
            self.database?.save()
        }
		delegate?.textViewDidEndEditing(textView, in: self)
    }
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if text == "\n", delegate?.textViewShouldReturn(textView, in: self) ?? false {
			return false
		} else {
			return true
		}
	}
}
