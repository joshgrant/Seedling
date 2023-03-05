// Copyright Team Seedling ©

import UIKit

class CheckboxCell: UITableViewCell, SettingsCell
{
    func configure(with item: Item)
    {
        
    }
}

extension CheckboxCell
{
    struct Item: SettingsItem
    {
        static let reuseIdentifier: String = "checkbox"
        
        let id = UUID()
        
        var content: String
        var checked: Bool
        var description: String?
        
        var action: () -> Void
    }
}
