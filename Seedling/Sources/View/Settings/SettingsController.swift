// Copyright Team Seedling ©

import UIKit

protocol Component {}

class SettingsController: UIViewController
{
    // MARK: - Variables
    
    private(set) var components: [Component] = []
    
    // MARK: - Initialization
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
        
        components = [
            TabComponent(tab: .settings, controller: self)
        ]
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
