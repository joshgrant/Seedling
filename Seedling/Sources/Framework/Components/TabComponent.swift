// Copyright Team Seedling ©

import UIKit

class TabComponent
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

extension TabComponent
{
    struct Tab
    {
        var title: String
        var image: UIImage?
        var selectedImage: UIImage?
        
        static let toDo = Tab(title: Strings.toDo.localizedCapitalized, image: SeedlingAsset.toDoUnselected.image, selectedImage: SeedlingAsset.toDoSelected.image)
        static let schedule = Tab(title: Strings.schedule.localizedCapitalized, image: SeedlingAsset.scheduleUnselected.image, selectedImage: SeedlingAsset.scheduleSelected.image)
        static let extras = Tab(title: Strings.extras.localizedCapitalized, image: SeedlingAsset.extrasUnselected.image, selectedImage: SeedlingAsset.extrasSelected.image)
        static let settings = Tab(title: Strings.settings.localizedCapitalized, image: SeedlingAsset.settingsUnselected.image, selectedImage: SeedlingAsset.settingsSelected.image)
    }
}
