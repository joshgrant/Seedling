// Copyright Team Seedling ©

import UIKit
import CoreData

class TodoTableViewComponent: NSObject, TableViewComponent
{
    typealias Section = DailyTaskSection
    typealias Item = Task
    
    // MARK: - Variables
    
    var context: NSManagedObjectContext
    var tableView: UITableView
    var scrollViewDidScroll: (_ y: CGFloat) -> Void
    
    private var taskManagerComponent: TaskManagerComponent
    
    lazy var dataSource = DataSource(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, id in
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellIdentifier", for: indexPath)
        if let cell = cell as? TaskCell
        {
            cell.configure(with: id)
            cell.delegate = self
            cell.checkBoxDelegate = self
            cell.context = self?.context
        }
        return cell
    })
    
    var fetchRequest: NSFetchRequest<Section>
    var fetchController: NSFetchedResultsController<Section>
    
    // MARK: - Initialization
    
    init(context: NSManagedObjectContext, day: Day, scrollViewDidScroll: @escaping (CGFloat) -> Void)
    {
        self.context = context
        self.scrollViewDidScroll = scrollViewDidScroll
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = .leastNormalMagnitude
        tableView.backgroundColor = .systemBackground
        // TODO: Not great...
        tableView.register(TaskCell.self, forCellReuseIdentifier: "taskCellIdentifier")
        tableView.register(TaskSectionCell.self, forCellReuseIdentifier: "taskSectionCellIdentifier")
        self.tableView = tableView
        let fetchRequest = Self.makeDayFetchRequest(day: day)
        fetchController = Self.makeFetchController(with: fetchRequest, context: context)
        self.fetchRequest = fetchRequest
        self.taskManagerComponent = TaskManagerComponent(context: context)
        super.init()
        tableView.delegate = self
        // TODO: Duplication
        fetchController.delegate = self
        try! fetchController.performFetch() // TODO: Don't force
    }
    
    // MARK: - Functions
    func updateDay(day: Day)
    {
        // TODO: Does changing day currently dismiss the task/keyboard
        taskManagerComponent.state = .inactive
        fetchRequest = Self.makeDayFetchRequest(day: day)
        fetchController = Self.makeFetchController(with: fetchRequest, context: context)
        fetchController.delegate = self
        try! fetchController.performFetch() // TODO: Don't force
    }
    
    static func makeDayFetchRequest(day: Day) -> NSFetchRequest<Section>
    {
        let fetchRequest: NSFetchRequest<Section> = Section.fetchRequest()
        let (startDate, endDate) = day.date!.dateRange
        fetchRequest.predicate = NSPredicate(format: "day.date >= %@ AND day.date <= %@", argumentArray: [startDate, endDate])
        fetchRequest.sortDescriptors = [
            .init(keyPath: \DailyTaskSection.sortIndex, ascending: true)
        ]
        return fetchRequest
    }
    
    static func makeFetchController<T: NSFetchRequestResult>(with fetchRequest: NSFetchRequest<T>, context: NSManagedObjectContext) -> NSFetchedResultsController<T> {
        .init(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
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
        dataSource.apply(newSnapshot, animatingDifferences: true)
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
        // TODO: Check firstResponder
//        if let responder = tableView.currentFirstResponder()
//        {
//            responder.resignFirstResponder()
//        }
        taskManagerComponent.addButtonPressed(section: sender.section)
    }
    
    
}

extension TodoTableViewComponent
{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        switch taskManagerComponent.state
        {
        case .editingEmptyTask(let taskToEdit), .editingTaskWithContent(let taskToEdit):
            let task = dataSource.itemIdentifier(for: indexPath)
            if task == taskToEdit, let cell = cell as? TaskCell
            {
                cell.textView.becomeFirstResponder()
            }
        case .inactive:
            break
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
        guard let task = dataSource.itemIdentifier(for: indexPath) else { return .none }
        
        switch taskManagerComponent.state
        {
        case .inactive:
            break
        case .editingEmptyTask(let taskToEdit), .editingTaskWithContent(let taskToEdit):
            if task == taskToEdit { return .none }
        }
        return UISwipeActionsConfiguration(actions: [.init(style: .destructive, title: Strings.delete.localizedCapitalized, handler: { [weak self] action, view, result in
            task
                .dailyTaskSection?
                .sortedTasks
                .filter { $0.sortIndex > task.sortIndex }
                .forEach { $0.sortIndex -= 1 }
            self?.context.delete(task)
            try? self?.context.save()
            result(true)
        })])
    }
}

extension TodoTableViewComponent: CellTextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView, in cell: UITableViewCell) { }
    
    func textViewDidChange(_ textView: UITextView, in cell: UITableViewCell)
    {
        taskManagerComponent.textViewDidChange(content: textView.text)
        tableView.performBatchUpdates({
            UIView.animate(withDuration: 0.0) {
                cell.contentView.setNeedsLayout()
                cell.contentView.layoutIfNeeded()
            }
        }, completion: nil)
    }
    
    func textViewDidEndEditing(_ textView: UITextView, in cell: UITableViewCell)
    {
        taskManagerComponent.textViewEndedEditing()
    }
    
    func textViewShouldReturn(_ textView: UITextView, in cell: UITableViewCell) -> Bool
    {
        taskManagerComponent.returnButtonPressed()
        return true
    }
}

extension TodoTableViewComponent: UIScrollViewDelegate
{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    {
        scrollView.endEditing(false)
        taskManagerComponent.scrollViewEndedEditing()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        scrollViewDidScroll(scrollView.contentOffset.y)
    }
}

extension TodoTableViewComponent: CheckBoxDelegate
{
    func checkBoxWillTouchUpInside(_ sender: TaskCell) {
        
    }
    
    func checkBoxDidTouchUpInside(_ sender: TaskCell) {
        guard let task = sender.task else { return }
        
        if task.completed
        {
            modifySortIndexAfterTaskMarkedComplete(task: task)
        }
        else
        {
            modifySortIndexAfterTaskMarkedIncomplete(task: task)
        }
        
        try? context.save()
        try? fetchController.performFetch()
    }
    
    func modifySortIndexAfterTaskMarkedComplete(task: Task)
    {
        let sortedTasks = task.dailyTaskSection?.sortedTasks ?? []
        var index = Int(task.sortIndex + 1)
        while index < sortedTasks.count && !sortedTasks[index].completed
        {
            sortedTasks[index].sortIndex -= 1
            index += 1
        }
        task.sortIndex = Int32(index - 1)
    }
    
    func modifySortIndexAfterTaskMarkedIncomplete(task: Task)
    {
        let sortedTasks = task.dailyTaskSection?.sortedTasks ?? []
        var index = Int(task.sortIndex - 1)
        while index >= 0 && sortedTasks[index].completed
        {
            sortedTasks[index].sortIndex += 1
            index -= 1
        }
        task.sortIndex = Int32(index + 1)
    }
}
