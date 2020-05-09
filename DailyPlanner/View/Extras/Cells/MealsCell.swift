//
//  MealsCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class MealsCell: UITableViewCell {
    
    var breakfastHeight: NSLayoutConstraint!
    var lunchHeight: NSLayoutConstraint!
    var dinnerHeight: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let breakfast = UIStackView(arrangedSubviews: [
            makeLabel(title: "Breakfast:"),
            makeTextView(placeholder: "None")])
        breakfast.axis = .vertical
        breakfast.spacing = 6
        
        let lunch = UIStackView(arrangedSubviews: [
            makeLabel(title: "Lunch:"),
            makeTextView(placeholder: "None")
        ])
        lunch.axis = .vertical
        lunch.spacing = 6
        
        let dinner = UIStackView(arrangedSubviews: [
            makeLabel(title: "Dinner:"),
            makeTextView(placeholder: "None")
        ])
        
        dinner.axis = .vertical
        dinner.spacing = 6
        
        let vStack = UIStackView(arrangedSubviews: [
            breakfast, lunch, dinner
        ])
        vStack.spacing = 10
        
        vStack.axis = .vertical
        
        let leftPadding = UIView()
        leftPadding.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        let rightPadding = UIView()
        rightPadding.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        let hStack = UIStackView(arrangedSubviews: [leftPadding, vStack, rightPadding])
        
        contentView.embed(view: hStack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeLabel(title: String) -> UILabel {
        let label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(named: "text")
        label.text = title
        return label
    }
    
    func makeTextView(placeholder: String) -> UITextView {
        let textView = UITextView()
        textView.textColor = UIColor(named: "emerald")
        textView.heightAnchor.constraint(equalToConstant: 54).isActive = true
        textView.font = .monospacedSystemFont(ofSize: 17, weight: .regular)
        textView.layer.borderColor = UIColor(named: "separator")?.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 4
        return textView
    }
}
