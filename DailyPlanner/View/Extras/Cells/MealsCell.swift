//
//  MealsCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class MealsCell: UITableViewCell {
	
	weak var delegate: CellTextViewDelegate?
	
	var breakfastTextView: TextView
	var lunchTextView: TextView
	var dinnerTextView: TextView
	
	var meal: Meal?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		
		breakfastTextView = Self.makeTextView(placeholder: "Breakfast")
		lunchTextView = Self.makeTextView(placeholder: "Lunch")
		dinnerTextView = Self.makeTextView(placeholder: "Dinner")
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		breakfastTextView.delegate = self
		lunchTextView.delegate = self
		dinnerTextView.delegate = self
        
        selectionStyle = .none
        
        let breakfast = UIStackView(arrangedSubviews: [
			Self.makeLabel(title: "Breakfast:"),
            breakfastTextView])
        breakfast.axis = .vertical
        breakfast.spacing = 6
        
        let lunch = UIStackView(arrangedSubviews: [
			Self.makeLabel(title: "Lunch:"),
            lunchTextView
        ])
        lunch.axis = .vertical
        lunch.spacing = 6
        
        let dinner = UIStackView(arrangedSubviews: [
			Self.makeLabel(title: "Dinner:"),
            dinnerTextView
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
	
	func configure(with meal: Meal) {
		self.meal = meal
		
		self.breakfastTextView.text = meal.breakfast
		self.lunchTextView.text = meal.lunch
		self.dinnerTextView.text = meal.dinner
	}
	
	// MARK: - Factories
    
    static func makeLabel(title: String) -> UILabel {
        let label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 17, weight: .regular)
		label.textColor = .type(.text)
        label.text = title
        return label
    }
    
    static func makeTextView(placeholder: String) -> TextView {
        let textView = TextView()
		textView.textColor = .type(.emerald)
        textView.heightAnchor.constraint(equalToConstant: 54).isActive = true
        textView.font = .monospacedSystemFont(ofSize: 17, weight: .regular)
		textView.layer.borderColor = UIColor.type(.separator).cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 4
        return textView
    }
}

extension MealsCell: UITextViewDelegate {

	func textViewDidBeginEditing(_ textView: UITextView) {
		delegate?.textViewDidBeginEditing(textView, in: self)
	}
	
	func textViewDidChange(_ textView: UITextView) {
		delegate?.textViewDidChange(textView, in: self)
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		delegate?.textViewDidEndEditing(textView, in: self)
		Database.context.perform {
			switch textView {
			case self.breakfastTextView:
				self.meal?.breakfast = textView.text
			case self.lunchTextView:
				self.meal?.lunch = textView.text
			case self.dinnerTextView:
				self.meal?.dinner = textView.text
			default:
				break
			}
			Database.save()
		}
	}
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if text == "\n", delegate?.textViewShouldReturn(textView, in: self) ?? false {
			return true
		} else {
			return false
		}
	}
}
