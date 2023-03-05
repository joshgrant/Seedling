// Copyright Team Seedling ©

import UIKit

class CenterButtonCell: UITableViewCell, SettingsCell
{
    func configure(with item: Item)
    {
        
    }
}

extension CenterButtonCell
{
    struct Item: SettingsItem
    {
        static let reuseIdentifier: String = "centerButton"
        
        let id = UUID()
        
        var title: String
        var image: UIImage?
        
        var action: () -> Void
    }
}
