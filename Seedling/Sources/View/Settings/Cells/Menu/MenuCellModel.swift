// Copyright Team Seedling ©

import Foundation

class MenuCellModel: SettingsCellModel, ObservableObject
{
    // MARK: - Variables
    
    var id = UUID()
    var title: String
    var options: [PickerOption]
    var selectionDidChange: (PickerOption) -> Void
    
    // MARK: - Initialization
    
    init(
        title: String,
        options: [PickerOption],
        selectionDidChange: @escaping (PickerOption) -> Void)
    {
        self.title = title
        self.options = options
        self.selectionDidChange = selectionDidChange
    }
}
