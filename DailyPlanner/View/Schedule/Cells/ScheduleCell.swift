//
//  ScheduleCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {
    
    let meridiemLabel: UILabel
    let hourLabel: UILabel
    let textView: UITextView
    
    weak var delegate: CellTextViewDelegate?
    var schedule: Schedule? // Pass this on custom init?
    
    var textViewHeight: NSLayoutConstraint!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        meridiemLabel.text = nil
        hourLabel.text = nil
        textView.text = nil
        textViewHeight.constant = 44
        textViewHeight.isActive = false
        
        delegate = nil
        schedule = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        meridiemLabel = UILabel()
        meridiemLabel.textColor = UIColor(named: "orange")
        meridiemLabel.font = .monospacedSystemFont(ofSize: 15, weight: .regular)
        meridiemLabel.widthAnchor.constraint(equalToConstant: 38).isActive = true
        meridiemLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        hourLabel = UILabel()
        hourLabel.textColor = UIColor(named: "orange")
        hourLabel.font = .monospacedSystemFont(ofSize: 15, weight: .regular)
        hourLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        textView = UITextView()
        textView.font = .monospacedSystemFont(ofSize: 17, weight: .regular)
        textView.textColor = UIColor(named: "text")
        textView.contentInset = .zero
        textViewHeight = textView.heightAnchor.constraint(equalToConstant: 44)
        textViewHeight.isActive = true
        textViewHeight.priority = .defaultLow
        textView.isScrollEnabled = false
        
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
        textView.textContainer.lineFragmentPadding = 0
        
        let spacer = UIView()
        spacer.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        let line = UIView()
        line.backgroundColor = UIColor(named: "separator")
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let hStack = UIStackView(arrangedSubviews: [spacer, line])
        
        let stackView = UIStackView(arrangedSubviews: [meridiemLabel, hourLabel, textView])
        
        let vStack = UIStackView(arrangedSubviews: [stackView, hStack])
        vStack.axis = .vertical
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        textView.delegate = self
        contentView.embed(view: vStack)
//        bottom.priority = .defaultLow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with schedule: Schedule?, delegate: CellTextViewDelegate) {
        self.schedule = schedule
        self.delegate = delegate
    }
}

extension ScheduleCell: UITextViewDelegate {
    
    // Not called with programmatic changes, just fyi
    func textViewDidChange(_ textView: UITextView) {
        let height = textView.text.height(with: .textView, constrainedTo: textView.frame.width)
        textViewHeight.constant = height
        
        delegate?.textViewDidChange(textView, in: self)
    }
}
