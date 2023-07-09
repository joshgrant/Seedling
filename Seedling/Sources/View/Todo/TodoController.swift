//
//  TodoController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit
import SwiftUI

class TodoController: UIViewController
{
    // MARK: - Variables
    
    unowned var dayProvider: DayProvider
    unowned var database: Database
    var previousRows: [Seedling.Task: Int] = [:]
    var tasks: [Seedling.Task]?
    
    lazy var model = CircularProgressIndicatorModel { [self] model, state in
        switch state {
        case .pulling:
            tasks = Seedling.Task.allUnfinishedTasks(in: database.context, before: dayProvider.day.date!)
            model.uncompletedCount = tasks!.count
        case .complete:
            let section = DailyTaskSection.findOrMakePreviousTaskSection(day: dayProvider.day, context: database.context)
            for t in tasks ?? [] {
                t.todoOfDay = nil
                t.priorityOfDay = nil
                t.dailyTaskSection = nil
                section.addToTasks(t)
            }
        case .inactive:
            tasks = nil
        default:
            break
        }
    }
    lazy var progressIndicator = UIHostingController(rootView: CircularProgressIndicator(model: model))
    lazy var tableViewComponent = TodoTableViewComponent(context: database.context, day: dayProvider.day, scrollViewDidScroll: { y in
        self.model.endAngle = -(y * Constants.updateTasksScrollMultiplier)
    })
    var tabComponent: TabComponent?
    var dayNavigationTitleComponent: DayNavigationTitleComponent?
    var updateDayComponent: UpdateDayComponent?
    
    // MARK: - Initialization
    
    init(dayProvider: DayProvider, database: Database)
    {
        self.dayProvider = dayProvider
        self.database = database
        
        super.init(nibName: nil, bundle: nil)
        tabComponent = .init(tab: .toDo, controller: self)
        
        progressIndicator.view.frame.size.height = Constants.progressIndicatorHeight
        tableViewComponent.tableView.contentInset = UIEdgeInsets(top: -Constants.progressIndicatorHeight, left: 0, bottom: 0, right: 0)
        tableViewComponent.tableView.tableHeaderView = progressIndicator.view
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    
    override func loadView()
    {
        self.view = tableViewComponent.tableView
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dayNavigationTitleComponent = .init(day: dayProvider.day, navigationItem: tabBarController?.navigationItem)
        updateDayComponent = .init(willUpdate: { _ in }, didUpdate: dayProviderDidUpdate)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        tableViewComponent.tableView.reloadData()
    }
    
    // MARK: - Functions
    
    func dayProviderDidUpdate(_ day: Day)
    {
        dayNavigationTitleComponent?.update(day: day)
        tableViewComponent.updateDay(day: day)
    }
}

extension TodoController
{
    private enum Constants
    {
        static let progressIndicatorHeight: CGFloat = 100
        static let updateTasksScrollMultiplier: CGFloat = 1.8
    }
}
//	override class func makeDelegate() -> TabContentDelegate
//	{
//        // TODO: Fix this because we'll rewrite the TabContentController
//        return ExtrasDelegate()
//	}
//
//	override class func makeDataSource(dayProvider: DayProvider) -> TabContentDataSource
//	{
//		return TodoDataSource(dayProvider: dayProvider)
//	}
//
//	override class func makeTabBarItem() -> UITabBarItem
//	{
//		return UITabBarItem(
//            title: Strings.toDo.localizedCapitalized,
//            image: SeedlingAsset.toDoUnselected.image,
//            selectedImage: SeedlingAsset.toDoSelected.image)
//	}
//
//	override class func makeCellClassIdentifiers() -> [CellClassIdentifier]
//	{
//		return [
//			.init(cellClass: TaskCell.self, cellReuseIdentifier: "taskCell")
//		]
//	}
//
//	override func configureDelegate()
//	{
//		(delegate as? TodoDelegate)?.tableView = tableView
//		(delegate as? TodoDelegate)?.dayProvider = dayProvider
//        (delegate as? TodoDelegate)?.database = database
//
//        tableView.delegate = (delegate as? TodoDelegate)
//	}
//
//	override func configureDataSource()
//	{
//		(dataSource as? TodoDataSource)?.cellTextViewDelegate = self
//        (dataSource as? TodoDataSource)?.database = database
//        (dataSource as? TodoDataSource)?.checkBoxDelegate = self
//	}

