//
//  NotesCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
        
        let textView = UITextView()
        textView.font = .monospacedSystemFont(ofSize: 17, weight: .regular)
        textView.textColor = UIColor(named: "text")
        
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
    
}
