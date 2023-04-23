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
        tableView.sectionHeaderTopPadding = .leastNormalMagnitude
        tableView.backgroundColor = .systemBackground
        // TODO: Not great...
        tableView.register(TaskCell.self, forCellReuseIdentifier: "taskCellIdentifier")
        tableView.register(TaskSectionCell.self, forCellReuseIdentifier: "taskSectionCellIdentifier")
        
        // TODO: With no cells in a section, the section itself is hidden
        self.dataSource = .init(tableView: tableView, cellProvider: { tableView, indexPath, id in
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellIdentifier", for: indexPath)
            if let cell = cell as? TaskCell { cell.configure(with: id) }
            return cell
        })
        
        self.tableView = tableView
        super.init()
        tableView.delegate = self
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
        let sections: [Section] = snapshot
            .itemIdentifiers
            .compactMap(mapSectionIdToSection)
            .sorted { $0.sortIndex < $1.sortIndex }
        newSnapshot.appendSections(sections)
        
        sections.forEach { section in
            guard let tasks = section
                .tasks?
                .compactMap({ element in element as? Task })
                .sorted(by: { first, second in first.sortIndex < second.sortIndex })
            else { return }
            
            newSnapshot.appendItems(tasks, toSection: section)
        }
        
        dataSource.apply(newSnapshot)
    }
    
    func mapSectionIdToSection(sectionId: Any) -> Section?
    {
        guard let sectionId = sectionId as? NSManagedObjectID else { return nil }
        guard let section = context.object(with: sectionId) as? Section else { return nil }
        return section
    }
}

extension TodoTableViewComponent
{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        guard let section = dataSource.sectionIdentifier(for: section) else { return nil }
        let content = section.title
        let button = SectionHeaderButton(section: section)
        configureButton(button: button)
        let view = TabContentHeader(content: content, button: button)
        return view
    }
    
    func configureButton(button: SectionHeaderButton)
    {
        button.addTarget(
            self,
            action: #selector(didTouchUpInsideButton),
            for: .touchUpInside)
    }
    
    // MARK: - Selectors
    
    @objc func didTouchUpInsideButton(_ sender: SectionHeaderButton)
    {
        tableView.performBatchUpdates({
            let count = sender.section.tasks?.count
            let task = Task(context: context)
            sender.section.addToTasks(task)
            let indexPath = IndexPath(item: count ?? 0, section: 0)
            // TODO: Create a new snapshot with new item included
            tableView.insertRows(at: [indexPath], with: .automatic)
//            editingIndexPath = indexPath
        }, completion: { _ in
            try? self.context.save()
            // TODO: Make a quick save
        })
    }
    
}

extension TodoTableViewComponent
{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        54
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        22
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
    {
        22
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
    {
        54
    }
}
