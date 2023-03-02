//
//  AppDelegate.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    static var database = Database(containerName: "Seedling")

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    -> Bool
    {
        // Override point for customization after application launch.
        
        let arguments = CommandLine.arguments
        let environment = ProcessInfo.processInfo.environment
        
        handle(arguments: arguments)
        handle(environment: environment)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions)
    -> UISceneConfiguration
    {
        UISceneConfiguration(
            name: "Scene",
            sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    
    // MARK: Arguments
    
    func handle(arguments: [String])
    {
        arguments
            .compactMap { LaunchArgument(rawValue: $0) }
            .map { LaunchArgumentMapper.argumentClass(from: $0) }
            .forEach { $0.handle() }
    }
    
    func handle(environment: [String: String])
    {
    }
}
