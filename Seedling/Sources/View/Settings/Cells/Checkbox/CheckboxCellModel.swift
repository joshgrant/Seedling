// Copyright Team Seedling ©

import Foundation

class CheckboxCellModel: SettingsCellModel, ObservableObject
{
    // MARK: - Variables
    
    @Published var isOn: Bool
    
    var id = UUID()
    var title: String
    var subtitle: String?
    var action: (Bool) -> Void
    
    // MARK: - Initialization
    
    init(
        isOn: Bool,
        title: String,
        subtitle: String? = nil,
        action: @escaping (Bool) -> Void)
    {
        self.isOn = isOn
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }
}
