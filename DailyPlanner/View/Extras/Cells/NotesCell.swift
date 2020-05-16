//
//  NotesCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {
	
	weak var delegate: CellTextViewDelegate?
	
	let textView: UITextView
	
	var note: Note?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		textView = UITextView()
		
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let leftPadding = UIView()
        leftPadding.widthAnchor.constraint(equalToConstant: 36).isActive = true
        let rightPadding = UIView()
        rightPadding.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
        let leftBorder = UIView()
        leftBorder.backgroundColor = UIColor(named: "orange")
        leftBorder.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        let rightBorder = UIView()
        rightBorder.backgroundColor = UIColor(named: "orange")
        rightBorder.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        textView.font = .monospacedSystemFont(ofSize: 17, weight: .regular)
        textView.textColor = UIColor(named: "text")
		textView.delegate = self
        
        let hStack = UIStackView(arrangedSubviews: [
            leftPadding,
            leftBorder,
            textView,
            rightBorder,
            rightPadding
        ])
        
        hStack.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
//        leftPadding.widthAnchor.constraint(equalTo: rightPadding.widthAnchor).isActive = true
        
        contentView.embed(view: hStack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	func configure(with note: Note) {
		self.note = note
		self.textView.text = note.content
	}
}


extension NotesCell: UITextViewDelegate {
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		delegate?.textViewDidBeginEditing(textView, in: self)
	}
	
	func textViewDidChange(_ textView: UITextView) {
		delegate?.textViewDidChange(textView, in: self)
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		self.note?.content = textView.text
		Database.save()
		delegate?.textViewDidEndEditing(textView, in: self)
	}
}
