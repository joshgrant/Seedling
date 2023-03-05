// Copyright Team Seedling ©

import UIKit

class PickerCell: UITableViewCell, SettingsCell
{
    func configure(with item: Item)
    {
        
    }
}

extension PickerCell
{
    struct PickerRow: Hashable, Identifiable
    {
        var id: UUID
        var title: String
    }
    
    struct Item: SettingsItem
    {
        static let reuseIdentifier: String = "picker"
        
        let id = UUID()
        
        var content: String
        var pickerRowProvider: () -> [PickerRow]
        var action: (PickerRow) -> Void
    }
}
