// Copyright Team Seedling ©

import Foundation

class TappableCellModel: SettingsCellModel, ObservableObject
{
    // MARK: - Initialization
    
    var id = UUID()
    var title: String
    var action: () -> Void
    
    init(title: String, action: @escaping () -> Void)
    {
        self.title = title
        self.action = action
    }
}
