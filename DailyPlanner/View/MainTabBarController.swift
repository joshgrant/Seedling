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
    
//    var date: Date
    
    var todo: TodoController
    var schedule: ScheduleController
    var extras: ExtrasController
    
    // MARK: - Initialization
    
    init?(dayProvider: DayProvider) {
        self.dayProvider = dayProvider
        
        todo = TodoController(dayProvider: dayProvider)!
        schedule = ScheduleController()!
        extras = ExtrasController()!
        
//        date = Date()
        
        super.init(coder: Coder())
        
        setViewControllers([todo, schedule, extras], animated: false)
        
        tabBar.barTintColor = UIColor(named: "emerald")
        tabBar.tintColor = .white
        tabBar.isTranslucent = true
        tabBar.unselectedItemTintColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowtriangle.left.fill"), style: .plain, target: self, action: #selector(didTouchUpInsideLeftButton(_:)))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "emerald")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowtriangle.right.fill"), style: .plain, target: self, action: #selector(didTouchUpInsideRightButton(_:)))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "emerald")
        
        setNavigationTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setNavigationTitle() {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        if let date = dayProvider.day.date {
            let title = formatter.string(from: date)
            navigationItem.title = title
        } else {
            let title = "Today"
            navigationItem.title = title
        }
    }
    
    @objc func didTouchUpInsideLeftButton(_ sender: UIBarButtonItem) {
        dayProvider.day = dayProvider.yesterday
        setNavigationTitle()
    }
    
    @objc func didTouchUpInsideRightButton(_ sender: UIBarButtonItem) {
        dayProvider.day = dayProvider.tomorrow
        setNavigationTitle()
    }
}
