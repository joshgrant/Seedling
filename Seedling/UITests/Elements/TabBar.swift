//
//  TabBar.swift
//  DailyPlannerUITests
//
//  Created by Joshua Grant on 6/5/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import Foundation

class TabBar: BaseElement
{
    enum Tab: String
    {
        case toDo = "To Do"
        case schedule = "Schedule"
        case extras = "Extras"
    }
    
    func select(tab: Tab)
    {
        view.tabBars.buttons[tab.rawValue].tap()
    }
}
