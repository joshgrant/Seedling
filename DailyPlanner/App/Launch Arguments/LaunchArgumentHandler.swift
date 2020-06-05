//
//  LaunchArgumentHandler.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 6/5/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class LaunchArgumentHandler
{
    var rawValue: LaunchArgument { .launchArgument }
    
    func handle()
    {
        print("Running Tests")
    }
}

class ResetDatabase: LaunchArgumentHandler
{   
    override func handle()
    {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { $0.delegate as? SceneDelegate }
            .forEach { $0.database.reset() }
    }
}
