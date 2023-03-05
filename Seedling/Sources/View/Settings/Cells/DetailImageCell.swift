// Copyright Team Seedling ©

import UIKit

class DetailImageCell: UITableViewCell, SettingsCell
{
    func configure(with item: Item)
    {
            
    }
}

extension DetailImageCell
{
    struct Item: SettingsItem
    {
        static let reuseIdentifier: String = "detailImage"
        
        let id = UUID()
        
        var content: String
        var detailImage: UIImage
    }
}
