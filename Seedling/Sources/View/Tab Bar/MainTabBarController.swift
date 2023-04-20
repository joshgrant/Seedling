//
//  MainTabBarController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit
import SwiftUI

// TODO: This tab bar controller needs a view model

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
        
        settings = SettingsController(model: .init())
        
        todo = TodoController(dayProvider: dayProvider, database: database)!
        schedule = ScheduleController(dayProvider: dayProvider, database: database)!
        extras = ExtrasController(settingsController: settings, dayProvider: dayProvider, database: database)!
        
        super.init(coder: Coder())
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        selectedIndex = 0
        
        if Settings.hideSettings
        {
            configureTabBarWithSwipableSettingsTab(animated: false)
        }
        else
        {
            configureTabBarWithVisibleSettingsTab(animated: false)
        }
        
        configureTabBar()
        configureNavigationBar()
        configureNavigationItem()
        registerForNotifications()
    }
    
    // MARK: - Configuration
    
    func configureTabBar()
    {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = SeedlingAsset.emerald.color
        
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemBackground,
            .paragraphStyle: NSParagraphStyle.default
        ]
        
        // When the icon is stacked above the image
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = titleTextAttributes
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = titleTextAttributes
        appearance.stackedLayoutAppearance.normal.iconColor = .systemBackground
        appearance.stackedLayoutAppearance.selected.iconColor = .systemBackground
        
        appearance.inlineLayoutAppearance.selected.titleTextAttributes = titleTextAttributes
        appearance.inlineLayoutAppearance.normal.titleTextAttributes = titleTextAttributes
        appearance.inlineLayoutAppearance.normal.iconColor = .systemBackground
        appearance.inlineLayoutAppearance.selected.iconColor = .systemBackground
        
        appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = titleTextAttributes
        appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = titleTextAttributes
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
            configureNavigationBarAppearance(navigationBar)
            
            let line = Spacer(height: 1)
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = .type(.emerald)
            
            navigationBar.addSubview(line)
            
            let tapGesture = createNavigationBarGestureRecognizer()
            navigationBar.addGestureRecognizer(tapGesture)
            
            NSLayoutConstraint.activate([
                navigationBar.bottomAnchor.constraint(equalTo: line.topAnchor),
                navigationBar.leadingAnchor.constraint(equalTo: line.leadingAnchor),
                navigationBar.trailingAnchor.constraint(equalTo: line.trailingAnchor)
            ])
        }
    }
    
    private func configureNavigationBarAppearance(_ navigationBar: UINavigationBar)
    {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.clear
        appearance.backgroundEffect = UIBlurEffect(style: .systemMaterial)
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: TextStyle.navigationBar.font,
            NSAttributedString.Key.foregroundColor: TextStyle.navigationBar.textColor
        ]
        
        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.configureWithTransparentBackground()
        compactAppearance.backgroundColor = UIColor.clear
        compactAppearance.backgroundEffect = UIBlurEffect(style: .systemMaterial)
        compactAppearance.titleTextAttributes = [
            NSAttributedString.Key.font: TextStyle.textView.font,
            NSAttributedString.Key.foregroundColor: TextStyle.navigationBar.textColor
        ]
        
        navigationBar.compactAppearance = compactAppearance
        navigationBar.compactScrollEdgeAppearance = compactAppearance
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    func createNavigationBarGestureRecognizer() -> UITapGestureRecognizer
    {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(didTouchUpInsideNavigationBar))
        return gestureRecognizer
    }
    
    func configureTabBarWithSwipableSettingsTab(animated: Bool)
    {
        setViewControllers([todo, schedule, extras], animated: animated)
    }
    
    func configureTabBarWithVisibleSettingsTab(animated: Bool)
    {
        setViewControllers([todo, schedule, extras, settings], animated: animated)
    }
    
    // MARK: - Notifications
    
    public func registerForNotifications()
    {
        NotificationCenter.default.addObserver(
            forName: .requestShowSettings,
            object: nil,
            queue: .main) { [unowned self] notification in
                configureTabBarWithVisibleSettingsTab(animated: false)
                
                if let object = notification.object as? [String: Any]
                {
                    if let shouldSwitch = object["switch_to_settings"] as? Bool
                    {
                        if shouldSwitch
                        {
                            self.selectedIndex = 3
                        }
                    }
                }
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
    
    @objc func didTouchUpInsideNavigationBar(_ sender: UITapGestureRecognizer)
    {
        dayProvider.day = dayProvider.today
    }
}

extension MainTabBarController
{
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
    {
        if Settings.hideSettings && item.tag != 3
        {
            configureTabBarWithSwipableSettingsTab(animated: true)
        }
    }
}
