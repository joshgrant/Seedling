// Copyright Team Seedling ©

import SwiftUI

class CenterButtonCellModel: SettingsCellModel, ObservableObject
{
    // MARK: - Variables
    
    var id = UUID()
    var title: String
    var image: SwiftUI.Image?
    var action: () -> Void
    
    // MARK: - Initialization
    
    init(title: String, image: SwiftUI.Image?, action: @escaping () -> Void)
    {
        self.title = title
        self.image = image
        self.action = action
    }
}
