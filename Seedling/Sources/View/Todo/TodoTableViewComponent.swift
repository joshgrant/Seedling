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
   
    private var taskToEdit: Task?
    
    lazy var dataSource = DataSource(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, id in
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellIdentifier", for: indexPath)
        if let cell = cell as? TaskCell
        {
            cell.configure(with: id)
            cell.delegate = self
        }
        return cell
    })
    
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
        guard taskToEdit == nil else { return }
        makeTask(section: sender.section)
    }
    
    func makeTask(section: TaskSection)
    {
        let count = section.tasks?.count ?? 0
        let task = Task(context: context)
        task.sortIndex = Int32(count)
        section.addToTasks(task)
        taskToEdit = task
    }
}

extension TodoTableViewComponent
{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let task = dataSource.itemIdentifier(for: indexPath)
        if task == taskToEdit
        {
            if let cell = cell as? TaskCell
            {
                cell.textView.becomeFirstResponder()
            }
        }
    }
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        guard let task = dataSource.itemIdentifier(for: indexPath), task != taskToEdit else { return .none }
        
        return UISwipeActionsConfiguration(actions: [.init(style: .destructive, title: SeedlingStrings.delete.localizedCapitalized, handler: { [weak self] action, view, result in
            self?.context.delete(task)
            result(true)
        })])
    }
}

extension TodoTableViewComponent: CellTextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView, in cell: UITableViewCell) { }
    
    func textViewDidChange(_ textView: UITextView, in cell: UITableViewCell) {
        taskToEdit?.content = textView.text
    }
    
    func textViewDidEndEditing(_ textView: UITextView, in cell: UITableViewCell)
    {
        guard let task = taskToEdit else { return }
        if task.content == nil || task.content == ""
        {
            context.delete(task)
            taskToEdit = nil
        }
        else if let section = task.taskSection
        {
            makeTask(section: section)
        }
    }
    
    func textViewShouldReturn(_ textView: UITextView, in cell: UITableViewCell) -> Bool
    {
        textView.resignFirstResponder()
        return true
    }
}
