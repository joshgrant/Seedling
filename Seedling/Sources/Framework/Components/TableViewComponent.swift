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

class TodoTableViewComponent: NSObject, TableViewComponent
{
    typealias Section = TaskSection
    typealias Item = Task
    
    // MARK: - Variables
    
    var context: NSManagedObjectContext
    var tableView: UITableView
    var dataSource: DataSource
    
    lazy var fetchRequest: NSFetchRequest<Task> = {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [
            .init(keyPath: \Task.taskSection, ascending: true),
            .init(keyPath: \Task.sortIndex, ascending: true)
        ]
        return fetchRequest
    }()
    
    lazy var fetchController: NSFetchedResultsController<Item> = {
        return .init(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "taskSection", cacheName: nil)
    }()
    
    // MARK: - Initialization
    
    init(context: NSManagedObjectContext)
    {
        self.context = context
        let tableView = UITableView()
        self.dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
            if let taskCell = cell as? TaskCell
            {
                taskCell.configure(with: item)
            }
            return cell
        })
        self.tableView = tableView
        super.init()
        fetchController.delegate = self
        
        // TODO: Better handling
        
        try! fetchController.performFetch()
    }
}

extension TodoTableViewComponent: NSFetchedResultsControllerDelegate
{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference)
    {
        dataSource.apply(<#T##snapshot: NSDiffableDataSourceSnapshot<Section, Item>##NSDiffableDataSourceSnapshot<Section, Item>#>, animatingDifferences: true) {
            print("Finished applying the snapshot!")
        }
    }
}
