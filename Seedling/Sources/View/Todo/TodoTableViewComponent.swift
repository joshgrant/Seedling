// Copyright Team Seedling ©

import UIKit
import CoreData

class TodoTableViewComponent: NSObject, TableViewComponent
{
    typealias Section = TaskSection
    typealias Item = Task
    
    // MARK: - Variables
    
    var context: NSManagedObjectContext
    var tableView: UITableView
    var dataSource: DataSource
    
    lazy var fetchRequest: NSFetchRequest<Section> = {
        let fetchRequest: NSFetchRequest<Section> = Section.fetchRequest()
        fetchRequest.sortDescriptors = [
            .init(keyPath: \TaskSection.sortIndex, ascending: true)
        ]
        return fetchRequest
    }()
    
    lazy var fetchController: NSFetchedResultsController<Section> = {
        .init(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    // MARK: - Initialization
    
    init(context: NSManagedObjectContext)
    {
        self.context = context
        let tableView = UITableView()
        tableView.separatorStyle = .none
        // TODO: Not great...
        tableView.register(TaskCell.self, forCellReuseIdentifier: "taskCellIdentifier")
        tableView.register(TaskSectionCell.self, forCellReuseIdentifier: "taskSectionCellIdentifier")
        
        self.dataSource = .init(tableView: tableView, cellProvider: { tableView, indexPath, id in
        print(id)
           fatalError("")
        })
        
        self.tableView = tableView
        super.init()
        
        fetchController.delegate = self
        try! fetchController.performFetch() // TODO: Don't force
    }
}

extension TodoTableViewComponent: NSFetchedResultsControllerDelegate
{
    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference)
    {
        var newSnapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        let sections: [Section] = snapshot.itemIdentifiers.compactMap { sectionId in
            guard let sectionId = sectionId as? NSManagedObjectID else { return nil }
            guard let section = context.object(with: sectionId) as? Section else { return nil }
            return section
        }
        // TODO: Sort sections
        newSnapshot.appendSections(sections)
        for section in sections
        {
            guard let tasks = section.tasks as? Set<Task> else { fatalError() }
            newSnapshot.appendItems(Array(tasks), toSection: section)
            // TODO: Sort items
        }
        dataSource.apply(newSnapshot)
    }
}
