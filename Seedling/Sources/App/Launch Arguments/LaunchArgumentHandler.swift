//
//  LaunchArgumentHandler.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 6/5/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class LaunchArgumentMapper
{
    static func argumentClass(from argument: LaunchArgument) -> LaunchArgumentHandler
    {
        switch argument
        {
        case .launchArgument:
            return LaunchArgumentHandler()
        case .resetDatabase:
            return ResetDatabase()
        case .populateDatabase:
            return PopulateDatabase()
        }
    }
}

class LaunchArgumentHandler
{
    func handle() { print("Running Tests") }
}

class ResetDatabase: LaunchArgumentHandler
{
    override func handle() { AppDelegate.database.reset() }
}

class PopulateDatabase: LaunchArgumentHandler
{
    override func handle() { AppDelegate.database.populateWithDefaultData(shouldReset: true) }
}
