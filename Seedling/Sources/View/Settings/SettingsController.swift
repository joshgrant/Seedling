// Copyright Team Seedling ©

import UIKit
import SwiftUI

class SettingsController: UIHostingController<SettingsView>
{
    // MARK: - Initialization
    
    var tabComponent: TabModule?
    
    init(model: SettingsViewModel)
    {
        super.init(rootView: SettingsView(model: model))
        tabComponent = .init(tab: .settings, controller: self)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
