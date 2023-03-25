// Copyright Team Seedling ©

import UIKit
import SwiftUI

class SettingsController: UIHostingController<SettingsView>
{
    // MARK: - Initialization
    
    init(model: SettingsViewModel)
    {
        super.init(rootView: SettingsView(model: model))
        
        tabBarItem = UITabBarItem(
            title: SeedlingStrings.settings,
            image: SeedlingAsset.settingsUnselected.image,
            selectedImage: SeedlingAsset.settingsSelected.image)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
