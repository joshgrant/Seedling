//
//  XCUIApplication+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 6/5/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import XCTest


extension XCUIApplication
{
    func launch(with arguments: [LaunchArgument])
    {
        launchArguments = arguments.map { $0.rawValue }
        launch()
    }
}
