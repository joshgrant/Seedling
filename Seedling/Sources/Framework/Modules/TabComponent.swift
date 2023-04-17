// Copyright Team Seedling ©

import UIKit

class TabModule
{
    // MARK: - Variables
    
    private var tab: Tab
    
    // MARK: - Initialization
    
    init(tab: Tab, controller: UIViewController)
    {
        self.tab = tab
        controller.tabBarItem = makeTabBarItem()
    }
    
    // MARK: - Private
    
    private func makeTabBarItem() -> UITabBarItem
    {
        UITabBarItem(
            title: tab.title,
            image: tab.image,
            selectedImage: tab.selectedImage)
    }
}

extension TabModule
{
    struct Tab
    {
        var title: String
        var image: UIImage?
        var selectedImage: UIImage?
        var tag: Int
        
        static let toDo = Tab(
            title: SeedlingStrings.toDo.localizedCapitalized,
            image: SeedlingAsset.toDoUnselected.image,
            selectedImage: SeedlingAsset.toDoSelected.image,
            tag: 0)
        static let schedule = Tab(
            title: SeedlingStrings.schedule.localizedCapitalized,
            image: SeedlingAsset.scheduleUnselected.image,
            selectedImage: SeedlingAsset.scheduleSelected.image,
            tag: 1)
        static let extras = Tab(
            title: SeedlingStrings.extras.localizedCapitalized,
            image: SeedlingAsset.extrasUnselected.image,
            selectedImage: SeedlingAsset.extrasSelected.image,
            tag: 2)
        static let settings = Tab(
            title: SeedlingStrings.settings.localizedCapitalized,
            image: SeedlingAsset.settingsUnselected.image,
            selectedImage: SeedlingAsset.settingsSelected.image,
            tag: 3)
    }
}
