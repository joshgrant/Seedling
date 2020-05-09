//
//  ExtrasController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class ExtrasController: UIViewController
{
	// MARK: - Variables
	
    let tableView: UITableView
	
	weak var dayProvider: DayProvider?
	
	// MARK: - Initialization
	
	init?(dayProvider: DayProvider)
	{
		self.dayProvider = dayProvider
		
		tableView = Self.makeTableView()
		
		super.init(coder: Coder())

		tabBarItem = Self.makeTabBarItem()
		
		configureTableView()
		configureView()

        view = tableView
    }
	
	required init?(coder: NSCoder) { fatalError() }
	
	// MARK: - Factories
	
	static func makeTableView() -> UITableView
	{
		return UITableView()
	}
	
	static func makeTabBarItem() -> UITabBarItem {
		return UITabBarItem(
			title: "Extras",
			image: .type(.extras),
			selectedImage: .type(.extrasSelected))
	}
	
	// MARK: - Configuration
	
	func configureView()
	{
		view = tableView
	}
	
	func configureTableView()
	{
		tableView.separatorStyle = .none
		tableView.keyboardDismissMode = .onDrag
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.register(MealsCell.self, forCellReuseIdentifier: "mealsCell")
		tableView.register(WaterCell.self, forCellReuseIdentifier: "waterCell")
		tableView.register(PomodoroCell.self, forCellReuseIdentifier: "pomodoroCell")
		tableView.register(NotesCell.self, forCellReuseIdentifier: "notesCell")
		
		tableView.delegate = self
		tableView.dataSource = self
	}
}

extension ExtrasController: UITableViewDataSource {
    
    func cellIdentifier(for indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return "mealsCell"
        case 1:
            return "waterCell"
        case 2:
            return "pomodoroCell"
        case 3:
            return "notesCell"
        default:
            return "cell"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = cellIdentifier(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        switch indexPath.section {
        case 0:
//            (cell as! MealsCell).text
			if let meal = dayProvider?.day.meal {
				(cell as? MealsCell)?.configure(with: meal)
			} // Else create the meal?
			// TODO: shouldn't creating a new day also create a new meal?
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
        
        return cell
    }
    
}

extension ExtrasController: UITableViewDelegate {
    
    // TODO: Copied from TodoController
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.font = UIFont.monospacedSystemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor(named: "orange")
        label.textAlignment = .center
        
        switch section {
        case 0:
            label.text = "Meals"
        case 1:
            label.text = "Water"
        case 2:
            label.text = "Pomodoro"
        case 3:
            label.text = "Notes"
        default:
            break
        }
        
        let topSpacer = UIView()
        let bottomSpacer = UIView()
        
        let vStack = UIStackView(arrangedSubviews: [
            topSpacer,
            label,
            bottomSpacer])
        vStack.axis = .vertical
        
        topSpacer.heightAnchor.constraint(equalTo: bottomSpacer.heightAnchor).isActive = true
        
        let effect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: effect)
        
//        visualEffectView.embed(view: vStack)
        visualEffectView.contentView.embed(view: vStack)
        
        return visualEffectView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 22
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension ExtrasController: CellTextViewDelegate {
	func textViewDidBeginEditing(_ textView: UITextView, in cell: UITableViewCell) {
		
	}
	
	func textViewDidChange(_ textView: UITextView, in cell: UITableViewCell) {
		
	}
	
	func textViewDidEndEditing(_ textView: UITextView, in cell: UITableViewCell) {
		
	}
	
	func textViewShouldReturn(_ textView: UITextView, in cell: UITableViewCell) -> Bool {
		// Perhaps edit the next cell?
		// And when at dinner, dismiss?
		
		return true
	}
}
