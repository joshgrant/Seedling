//
//  MainTabBarController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
	
	// MARK: - Variables
	
	unowned var dayProvider: DayProvider
	
	var todo: TodoController
	var schedule: ScheduleController
	var extras: ExtrasController
	
	// MARK: - Initialization
	
	init?(dayProvider: DayProvider) {
		self.dayProvider = dayProvider
		
		todo = TodoController(dayProvider: dayProvider)!
		schedule = ScheduleController(dayProvider: dayProvider)!
		extras = ExtrasController(dayProvider: dayProvider)!
		
		super.init(coder: Coder())
		
		setViewControllers([todo, schedule, extras], animated: false)
        
        configureTabBar()
        configureNavigationItem()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		selectedIndex = 0
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		configureNavigationBar()
	}
	
	// MARK: - Configuration
    
    func configureTabBar() {
        tabBar.barTintColor = .type(.emerald)
        tabBar.tintColor = .systemBackground
        tabBar.isTranslucent = true
        tabBar.unselectedItemTintColor = .secondarySystemBackground
    }
    
    func configureNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrowtriangle.left.fill"),
            style: .plain,
            target: self,
            action: #selector(didTouchUpInsideLeftButton(_:)))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "emerald")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrowtriangle.right.fill"),
            style: .plain,
            target: self,
            action: #selector(didTouchUpInsideRightButton(_:)))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "emerald")
    }
	
	func configureNavigationBar()
	{
		if let navigationBar = navigationController?.navigationBar {
            
            navigationBar.tintColor = .white
            navigationBar.barTintColor = .white
			
			let line = Spacer(height: 1)
			line.translatesAutoresizingMaskIntoConstraints = false
			line.backgroundColor = .type(.emerald)
			
			navigationBar.addSubview(line)
			
			NSLayoutConstraint.activate([
				navigationBar.bottomAnchor.constraint(equalTo: line.topAnchor),
				navigationBar.leadingAnchor.constraint(equalTo: line.leadingAnchor),
				navigationBar.trailingAnchor.constraint(equalTo: line.trailingAnchor)
			])
		}
	}
	
	// MARK: - Actions
	
	@objc func didTouchUpInsideLeftButton(_ sender: UIBarButtonItem)
	{
		dayProvider.day = dayProvider.yesterday
	}
	
	@objc func didTouchUpInsideRightButton(_ sender: UIBarButtonItem)
	{
		dayProvider.day = dayProvider.tomorrow
	}
}
