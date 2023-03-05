// Copyright Team Seedling ©

import UIKit

class DetailNavigationCell: UITableViewCell, SettingsCell
{
    func configure(with item: Item)
    {
        
    }
}

extension DetailNavigationCell
{
    struct Item: SettingsItem
    {
        static let reuseIdentifier: String = "detailNavigation"
        
        let id = UUID()

        var content: String
        var action: () -> Void
    }
}
