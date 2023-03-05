// Copyright Team Seedling ©

import UIKit

protocol SettingsCell: UITableViewCell
{
    associatedtype Item: SettingsItem
    
    static func make(
        tableView: UITableView,
        indexPath: IndexPath,
        item: Item)
    -> UITableViewCell
    
    func configure(with item: Item)
}

extension SettingsCell
{
    static func make(
        tableView: UITableView,
        indexPath: IndexPath,
        item: Item)
    -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: type(of: item).reuseIdentifier,
            for: indexPath)
        
        guard let cell = cell as? Self else
        {
            return cell
        }
        
        cell.configure(with: item)
        return cell
    }
}
