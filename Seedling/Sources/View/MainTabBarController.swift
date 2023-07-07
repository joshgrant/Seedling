//
//  MainTabBarController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit
import SwiftUI

class MainTabBarController: UITabBarController
{
    // MARK: - Variables
    
    unowned var dayProvider: DayProvider
    unowned var database: Database
    
    var todo: TodoController
    var schedule: ScheduleController
    var extras: ExtrasController
    var settings: SettingsController
    
    // MARK: - Initialization
    
    init?(dayProvider: DayProvider, database: Database)
    {
        self.dayProvider = dayProvider
        self.database = database
        
        todo = TodoController(dayProvider: dayProvider, database: database)
        schedule = ScheduleController(dayProvider: dayProvider, database: database)!
        extras = ExtrasController(dayProvider: dayProvider, database: database)!
        settings = SettingsController(context: database.context)
        
        super.init(coder: Coder())
        
        setViewControllers([todo, schedule, extras, settings], animated: false)
        
        configureTabBar()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        selectedIndex = 0
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        configureNavigationBar()
        configureNavigationItem()
    }
    
    // MARK: - Configuration
    
    func configureTabBar()
    {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = SeedlingAsset.emerald.color
        
        // When the icon is stacked above the image
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        appearance.stackedLayoutAppearance.normal.iconColor = .systemBackground
        appearance.stackedLayoutAppearance.selected.iconColor = .systemBackground
        
        appearance.inlineLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        appearance.inlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        appearance.inlineLayoutAppearance.normal.iconColor = .systemBackground
        appearance.inlineLayoutAppearance.selected.iconColor = .systemBackground
        
        appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        appearance.compactInlineLayoutAppearance.normal.iconColor = .systemBackground
        appearance.compactInlineLayoutAppearance.selected.iconColor = .systemBackground
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    func configureNavigationItem()
    {
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
        if let navigationBar = navigationController?.navigationBar
        {
            let line = Spacer(height: 1)
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = .type(.emerald)
            
            navigationBar.addSubview(line)
            
            let tapGesture = createNavigationBarGestureRecognizer()
            navigationBar.addGestureRecognizer(tapGesture)
            
            let longPressGesture = createNavigationBarLongPressGestureRecognizer()
            navigationBar.addGestureRecognizer(longPressGesture)
            
            NSLayoutConstraint.activate([
                navigationBar.bottomAnchor.constraint(equalTo: line.topAnchor),
                navigationBar.leadingAnchor.constraint(equalTo: line.leadingAnchor),
                navigationBar.trailingAnchor.constraint(equalTo: line.trailingAnchor)
            ])
        }
    }
    
    func createNavigationBarGestureRecognizer() -> UITapGestureRecognizer
    {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(didTouchUpInsideNavigationBar))
        return gestureRecognizer
    }
    
    func createNavigationBarLongPressGestureRecognizer() -> UILongPressGestureRecognizer
    {
        let gestureRecognizer = UILongPressGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(didLongPressInsideNavigationBar))
        return gestureRecognizer
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
    
    @objc func didTouchUpInsideNavigationBar(_ sender: UITapGestureRecognizer)
    {
        dayProvider.day = dayProvider.today
    }
    
    @objc func didLongPressInsideNavigationBar(_ sender: UILongPressGestureRecognizer)
    {
        switch sender.state
        {
        case .began:
            let viewController = DayPickerController(context: database.context, dayProvider: dayProvider)
            present(viewController, animated: true, completion: nil)
        default: break
        }
    }
}
