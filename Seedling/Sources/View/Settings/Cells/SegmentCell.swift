// Copyright Team Seedling ©

import UIKit

class SegmentCell: UITableViewCell, SettingsCell
{
    func configure(with item: Item)
    {
        
    }
}

extension SegmentCell
{
    struct Item: SettingsItem
    {
        static let reuseIdentifier: String = "segment"
        
        let id = UUID()
        
        var content: String
        var segments: [String]
        var action: (String) -> Void
    }
}
