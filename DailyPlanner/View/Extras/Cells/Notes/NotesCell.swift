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
	
	let textView: TextView
	
	var note: Note?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		textView = TextView()
		
        super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		textView.configure(with: .textView, delegate: self)
        
        selectionStyle = .none
		
		let leftPadding = Spacer(width: 36)
		let rightPadding = Spacer(width: 36)
		
		let leftBorder = Spacer(width: 1)
		leftBorder.backgroundColor = .type(.orange)
        
		let rightBorder = Spacer(width: 1)
		rightBorder.backgroundColor = .type(.orange)
        
        let hStack = UIStackView(arrangedSubviews: [
            leftPadding,
            leftBorder,
            textView,
            rightBorder,
            rightPadding
        ])
        
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
