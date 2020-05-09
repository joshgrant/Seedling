//
//  TaskCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    let checkBox: UIButton
    let textView: TextView
    
    weak var delegate: CellTextViewDelegate?
    
    var task: Task?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task = nil
        
        textView.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
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
        
        contentView.embed(view: vStack)
		
		textView.configure(with: .textView, delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with task: Task) {
        self.task = task
        
        textView.text = task.content
        
        if task.completed {
			checkBox.setImage(.type(.orangeBubble), for: .normal)
        } else {
			checkBox.setImage(.type(.clearBubble), for: .normal)
        }
    }
    
    @objc func didTouchUpInsideCheckBox(_ sender: UIButton) {
        Database.context.perform {
            self.task?.completed.toggle()
            if let task = self.task {
                self.configure(with: task)
            }
            Database.save() // Is it possible to create a retain loop here?
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
		delegate?.textViewDidEndEditing(textView, in: self)
        Database.context.perform {
            self.task?.content = textView.text
            Database.save()
        }
    }
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//		print(textView.text)
//		print(text)
//		print(textView.text.replacingCharacters(in: Range(range, in: textView.text)!, with: text))
		
		if text == "\n", delegate?.textViewShouldReturn(textView, in: self) ?? false {
			return true
		} else {
			return false
		}
	}
}
