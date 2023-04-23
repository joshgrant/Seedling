//
//  SceneDelegate.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit
import CoreData
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    lazy var dayProvider: DayProvider = {
        return DayProvider(database: AppDelegate.database)
    }()
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)

//        guard let tabBarController = MainTabBarController(dayProvider: dayProvider, database: AppDelegate.database) else { return }
//        let navigationController = UINavigationController(rootViewController: tabBarController)
        
        let model = TabBarModel(tabs: [
//            .init(item: .toDo, content: {
//                Text("1")
//            }),
//            .init(item: .schedule, content: {
//                Text("2")
//            }),
//            .init(item: .extras, content: {
//                Text("3")
//            }),
//            .init(item: .settings, content: {
//                Text("4")
//            })
        ])
        
        let rootView = TabBar(model: model)
        
        let testTabBarController = UIHostingController(rootView: rootView)
        
        window.rootViewController = testTabBarController
        
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene)
    {
		dayProvider.resetDay()
        movePreviousTasksToTodayIfNeeded(day: dayProvider.day)
    }
    
    func sceneWillResignActive(_ scene: UIScene)
    {
		window?.endEditing(false)
    }
    
    func sceneWillEnterForeground(_ scene: UIScene)
    {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene)
    {
        AppDelegate.database.save()
    }
    
    // MARK: - Utility
    
    func movePreviousTasksToTodayIfNeeded(day: Day)
    {
        let allUnfinishedTasks = Task.allUnfinishedHistoricalTasks(in: AppDelegate.database.context)
        
        for task in allUnfinishedTasks
        {
            task.todoOfDay = day
        }
        
        try? AppDelegate.database.context.save()
    }
}

