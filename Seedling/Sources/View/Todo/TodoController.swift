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
    enum Constants
    {
        static let updateTasksScrollMultiplier: CGFloat = 1.8
    }
    
    unowned var dayProvider: DayProvider
    unowned var database: Database
    var previousRows: [Task: Int] = [:]
    var model: CircularProgressIndicatorModel
    var progressIndicator: UIHostingController<CircularProgressIndicator>
    
    // MARK: - Initialization
    
    init(dayProvider: DayProvider, database: Database)
    {
        self.dayProvider = dayProvider
        self.database = database
        self.model = Self.makeModel()
        self.progressIndicator = .init(rootView: CircularProgressIndicator(model: self.model, uncompletedCount: 2))
        
        super.init(nibName: nil, bundle: nil)
        
        // TODO: Not great the way we're overriding the delegate. Will update when we refactor the TabContentController
//        delegate = TodoDelegate(scrollViewDidScroll: updateProgressIndicatorEndAngle)
//        tableView.delegate = delegate
//
//        progressIndicator.view.frame.size.height = 100
//        tableView.contentInset = UIEdgeInsets(top: -100, left: 0, bottom: 0, right: 0)
//        tableView.tableHeaderView = progressIndicator.view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func updateProgressIndicatorEndAngle(offset: CGFloat)
    {
        model.endAngle = -(offset * Constants.updateTasksScrollMultiplier)
    }
    
	// MARK: - Factories
    
    static func makeModel() -> CircularProgressIndicatorModel
    {
        CircularProgressIndicatorModel { state in
            switch state {
            case .complete:
                print("Time to fetch!")
            default:
                break
            }
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
//            title: SeedlingStrings.toDo.localizedCapitalized,
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
}

//extension TodoController: CheckBoxDelegate {
//    
//    func checkBoxWillTouchUpInside(_ sender: TaskCell) {
//        
//        // What about the priority array?
//        
//        guard let task = sender.task else { return }
//        guard let row = dayProvider.day.todosArray.firstIndex(of: task) else { return }
//        previousRows[task] = row
//    }
//    
//    func checkBoxDidTouchUpInside(_ sender: TaskCell) {
//        
//        guard let task = sender.task,
//              let previousRow = previousRows[task],
//              let currentRow = dayProvider.day.todosArray.firstIndex(of: task) else {
//            tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
//            return
//        }
//        
//        tableView.beginUpdates()
//        tableView.moveRow(at: IndexPath(row: previousRow, section: 1), to: IndexPath(row: currentRow, section: 1))
//        tableView.endUpdates()
//    }
//}
