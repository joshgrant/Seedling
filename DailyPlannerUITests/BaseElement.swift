//
//  BaseElement.swift
//  DailyPlannerUITests
//
//  Created by Joshua Grant on 5/30/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import XCTest

class BaseElement {
    
    var view: XCUIElement
    
    init(in view: XCUIElement)
    {
        self.view = view
    }
}

class TabBar: BaseElement {
    
    override init(in view: XCUIElement)
    {
        // Perhaps just init directly from the app...
        super.init(in: view)
    }
}
