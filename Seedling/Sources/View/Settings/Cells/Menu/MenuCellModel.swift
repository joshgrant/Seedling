// Copyright Team Seedling ©

import Foundation

class MenuCellModel<Option: PickerOption>: SettingsCellModel, ObservableObject
{
    // MARK: - Variables
    
    @Published var selection: Int
    {
        didSet
        {
            selectionDidChange(options[selection])
        }
    }
    
    var id = UUID()
    var title: String
    var options: [Option]
    var selectionDidChange: (Option) -> Void
    
    // MARK: - Initialization
    
    init(
        title: String,
        options: [Option],
        selection: Int,
        selectionDidChange: @escaping (Option) -> Void)
    {
        self.title = title
        self.options = options
        self.selection = selection
        self.selectionDidChange = selectionDidChange
    }
}
