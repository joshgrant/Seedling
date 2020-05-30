//
//  MealsCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class MealsCell: UITableViewCell
{
	// MARK: - Defined types
	
	enum Label: String
	{
		case breakfast = "Breakfast"
		case lunch = "Lunch"
		case dinner = "Dinner"
	}
	
	// MARK: - Variables
	
    weak var database: Database?
	weak var delegate: CellTextViewDelegate?
    
	var meal: Meal?
	
	var breakfastTextView: TextView
	var lunchTextView: TextView
	var dinnerTextView: TextView
	
	var breakfastStackView: UIStackView
	var lunchStackView: UIStackView
	var dinnerStackView: UIStackView
	
	var mealsStackView: UIStackView
	var contentStackView: UIStackView
	
	// MARK: - Initialization
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
	{
		breakfastTextView = Self.makeTextView(placeholder: "Breakfast")
		lunchTextView = Self.makeTextView(placeholder: "Lunch")
		dinnerTextView = Self.makeTextView(placeholder: "Dinner")
		
		breakfastStackView = Self.makeMealStackView()
		lunchStackView = Self.makeMealStackView()
		dinnerStackView = Self.makeMealStackView()
		
		mealsStackView = Self.makeMealsStackView()
		contentStackView = Self.makeContentStackView()
		
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		selectionStyle = .none
		
		configureView()
		
		configureContentStackView()
		configureMealsStackView()
		
		configureBreakfastStackView()
		configureLunchStackView()
		configureDinnerStackView()
		
		configureTextView(textView: breakfastTextView)
		configureTextView(textView: lunchTextView)
		configureTextView(textView: dinnerTextView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	// MARK: - Factories
    
    static func makeLabel(title: String) -> UILabel
	{
		let label = UILabel(style: .mealHeader)
		label.text = title
		return label
    }
    
    static func makeTextView(placeholder: String) -> TextView
	{
        let textView = TextView(minimumHeight: 54)
        return textView
    }
	
	static func makeMealStackView() -> UIStackView
	{
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 6
		return stackView
	}
	
	static func makeMealsStackView() -> UIStackView
	{
		let stackView = UIStackView()
		stackView.spacing = 10
		stackView.axis = .vertical
		return stackView
	}
	
	static func makeContentStackView() -> UIStackView
	{
		let stackView = UIStackView()
		return stackView
	}
	
	// MARK: - Configuration
	
	func configure(with meal: Meal)
	{
		self.meal = meal
		
		self.breakfastTextView.text = meal.breakfast
		self.lunchTextView.text = meal.lunch
		self.dinnerTextView.text = meal.dinner
	}
	
	func configureTextView(textView: TextView)
	{
        textView.configure(with: .mealContent, delegate: self)
        
        textView.layer.borderColor = UIColor.type(.separator).cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 4
	}
	
	func configureBreakfastStackView()
	{
		let breakfastTitle = "\(Label.breakfast.rawValue):"
		
		breakfastStackView.addArrangedSubview(Self.makeLabel(title: breakfastTitle))
		breakfastStackView.addArrangedSubview(breakfastTextView)
	}
	
	func configureLunchStackView()
	{
		let lunchTitle = "\(Label.lunch.rawValue):"
		
		lunchStackView.addArrangedSubview(Self.makeLabel(title: lunchTitle))
		lunchStackView.addArrangedSubview(lunchTextView)
	}
	
	func configureDinnerStackView()
	{
		let dinnerTitle = "\(Label.dinner.rawValue):"
		
		dinnerStackView.addArrangedSubview(Self.makeLabel(title: dinnerTitle))
		dinnerStackView.addArrangedSubview(dinnerTextView)
	}
	
	func configureMealsStackView()
	{
		mealsStackView.addArrangedSubview(breakfastStackView)
		mealsStackView.addArrangedSubview(lunchStackView)
		mealsStackView.addArrangedSubview(dinnerStackView)
	}
	
	func configureContentStackView()
	{
		contentStackView.addArrangedSubview(Spacer(width: 40))
		contentStackView.addArrangedSubview(mealsStackView)
		contentStackView.addArrangedSubview(Spacer(width: 40))
	}
	
	func configureView()
	{
		contentView.embed(view: contentStackView)
	}
}
