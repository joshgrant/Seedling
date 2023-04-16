// Copyright Team Seedling ©

import UIKit
import CoreData

protocol TableViewComponent
{
    associatedtype Section: Hashable
    associatedtype Item: Hashable
    typealias DataSource = UITableViewDiffableDataSource<Section, Item>
    
    // MARK: - Variables
    
    var tableView: UITableView { get set }
    var dataSource: DataSource { get set }
}
