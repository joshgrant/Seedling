//
//  MealsCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class MealsCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        
        let breakfast = UIStackView(arrangedSubviews: [
            makeLabel(title: "Breakfast:"),
            makeTextView(placeholder: "None")])
        breakfast.axis = .vertical
        
        let lunch = UIStackView(arrangedSubviews: [
            makeLabel(title: "Lunch:"),
            makeTextView(placeholder: "None")
        ])
        lunch.axis = .vertical
        
        let dinner = UIStackView(arrangedSubviews: [
            makeLabel(title: "Dinner:"),
            makeTextView(placeholder: "None")
        ])
        dinner.axis = .vertical
        
        let vStack = UIStackView(arrangedSubviews: [
            breakfast, lunch, dinner
        ])
        
        vStack.axis = .vertical
        
        contentView.embed(view: vStack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeLabel(title: String) -> UILabel {
        let label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(named: "text")
        return label
    }
    
    func makeTextView(placeholder: String) -> UITextView {
        let textView = UITextView()
        textView.textColor = UIColor(named: "emerald")
        textView.heightAnchor.constraint(equalToConstant: 54).isActive = true
        textView.font = .monospacedSystemFont(ofSize: 17, weight: .regular)
        return textView
    }
}
