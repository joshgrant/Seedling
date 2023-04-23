// Copyright Team Seedling ©

import SwiftUI

class TabBarModel: ObservableObject
{
    var tabs: [TabBarView]
    
    var selectedTab: TabBarView?
    {
        tabs.first { $0.item == selectedItem }
    }
    
    var selectedItem: TabBarItemModel?
    {
        didSet
        {
            tabs.forEach { $0.item.selected = false }
            selectedItem?.selected = true
        }
    }
    
    init(tabs: [TabBarView])
    {
        self.tabs = tabs
    }
}

