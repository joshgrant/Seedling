//
//  BaseElement.swift
//  DailyPlannerUITests
//
//  Created by Joshua Grant on 5/30/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import XCTest

class BaseElement
{
    // MARK: - Variables
    
    var view: XCUIElement
    
    // MARK: - Initialization
    
    init(in view: XCUIElement)
    {
        self.view = view
    }
}
