// Copyright Team Seedling ©

import UIKit
import CoreData

protocol TableViewComponent
{
    associatedtype Section: Hashable
    associatedtype Item: Hashable
    typealias DataSource = UITableViewDiffableDataSourceReference
    
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
        
        self.dataSource = .init(tableView: tableView, cellProvider: { tableView, indexPath, item in
            switch item
            {
            case let task as Task:
                let cell = tableView.dequeueReusableCell(withIdentifier: task.identifier, for: indexPath)
                if let taskCell = cell as? TaskCell
                {
                    taskCell.configure(with: task)
                }
                return cell
            case let taskSection as TaskSection:
                let cell = tableView.dequeueReusableCell(withIdentifier: taskSection.identifier, for: indexPath)
                if let taskSectionCell = cell as? TaskSectionCell
                {
                    taskSectionCell.configure(with: taskSection)
                }
                return cell
            default:
                fatalError()
            }
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
    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference)
    {
        dataSource.applySnapshot(snapshot, animatingDifferences: true)
    }
}
