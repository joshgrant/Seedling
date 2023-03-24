// Copyright Team Seedling ©

import UIKit

protocol TableViewComponent
{
    associatedtype Section: Hashable
    associatedtype Item: Hashable
    typealias DataSource = UITableViewDiffableDataSource<Section, Item>
    
    // MARK: - Variables
    
    var tableView: UITableView { get set }
    var dataSource: DataSource { get set }
    
}

class TodoTableViewComponent: TableViewComponent
{
    enum Section
    {
        case tasks
    }
    
    enum Item
    {
        case task
        
        var identifier: String
        {
            switch self
            {
            case .task: return "taskCell"
            }
        }
    }
    
    // MARK: - Variables
    
    var tableView: UITableView
    var dataSource: DataSource
    
    // MARK: - Initialization
    
    init()
    {
        let tableView = UITableView()
        self.dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: itemIdentifier.identifier, for: indexPath)
            if let taskCell = cell as? TaskCell
            {
                taskCell.textView.text = "Hello"
            }
            return cell
        })
        self.tableView = tableView
    }
}
