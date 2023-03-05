// Copyright Team Seedling ©

import UIKit

class SettingsController: UIViewController
{
    // MARK: - Types
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Item>
    typealias CellProvider = DataSource.CellProvider
    
    // MARK: - Variables
    
    let tableView = UITableView()
    
    lazy var tabModule = TabModule(tab: .settings, controller: self)
    
    lazy var dataSource: DataSource = .init(
        tableView: tableView,
        cellProvider: Self.makeCellProvider())
    
    // MARK: - Initialization
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
        
        _ = tabModule
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    
    override func loadView()
    {
        tableView.dataSource = dataSource
        view = tableView
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.register(
            CheckboxCell.self,
            forCellReuseIdentifier: CheckboxCell.Item.reuseIdentifier)
        
        applyInitialSnapshot()
    }
    
    // MARK: - Factory
    
    private static func makeCellProvider() -> CellProvider
    {
        return { tableView, indexPath, itemIdentifier in
            switch itemIdentifier
            {
            case .checkbox(let item):
                return CheckboxCell.make(
                    tableView: tableView,
                    indexPath: indexPath,
                    item: item)
            case .detailNavigation(let item):
                return DetailNavigationCell.make(
                    tableView: tableView,
                    indexPath: indexPath,
                    item: item)
            case .segmentItem(let item):
                return SegmentCell.make(
                    tableView: tableView,
                    indexPath: indexPath,
                    item: item)
            case .pickerItem(let item):
                return PickerCell.make(
                    tableView: tableView,
                    indexPath: indexPath,
                    item: item)
            case .detailImageItem(let item):
                return DetailImageCell.make(
                    tableView: tableView,
                    indexPath: indexPath,
                    item: item)
            case .centerButtonItem(let item):
                return CenterButtonCell.make(
                    tableView: tableView,
                    indexPath: indexPath,
                    item: item)
            }
        }
    }
    
    private func applyInitialSnapshot()
    {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections([
            .general,
            .tasks,
            .schedule,
            .extras,
            .info])
        
        snapshot.appendItems(
            [
                .checkbox(.init(content: "Hide settings", checked: false, description: "To access settings, swipe right on the extras page", action: {})),
                .checkbox(.init(content: "Monospaced font", checked: true, action: {})),
                .checkbox(.init(content: "Lowecase text", checked: false, action: {})),
                .checkbox(.init(content: "Format notes with Markdown", checked: false, action: {})),
                .checkbox(.init(content: "Haptic feedback", checked: true, action: {}))
            ],
            toSection: .general)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension SettingsController
{
    struct Section: Identifiable, Hashable
    {
        var id = UUID()
        var sortIndex: Int
        
        static let general = Section(sortIndex: 0)
        static let tasks = Section(sortIndex: 1)
        static let schedule = Section(sortIndex: 2)
        static let extras = Section(sortIndex: 3)
        static let info = Section(sortIndex: 4)
    }
    
    enum Item: Identifiable, Hashable
    {
        case checkbox(CheckboxCell.Item)
        case detailNavigation(DetailNavigationCell.Item)
        case segmentItem(SegmentCell.Item)
        case pickerItem(PickerCell.Item)
        case detailImageItem(DetailImageCell.Item)
        case centerButtonItem(CenterButtonCell.Item)
        
        var id: UUID
        {
            switch self {
            case .checkbox(let item):
                return item.id
            case .detailNavigation(let item):
                return item.id
            case .segmentItem(let item):
                return item.id
            case .pickerItem(let item):
                return item.id
            case .detailImageItem(let item):
                return item.id
            case .centerButtonItem(let item):
                return item.id
            }
        }
    }
}
