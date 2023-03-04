//
//  TodoController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TodoController: TabContentController
{
	// MARK: - Variables
	
	enum Section: Int {
		case priorities
		case todos
	}
    
    var previousRows: [Task: Int] = [:]
	
	// MARK: - Factories
	
	override class func makeDelegate() -> TabContentDelegate
	{
		return TodoDelegate()
	}
	
	override class func makeDataSource(dayProvider: DayProvider) -> TabContentDataSource
	{
		return TodoDataSource(dayProvider: dayProvider)
	}
	
	override class func makeTabBarItem() -> UITabBarItem
	{
		return UITabBarItem(
            title: SeedlingStrings.toDo.localizedCapitalized,
            image: SeedlingAsset.toDoUnselected.image,
            selectedImage: SeedlingAsset.toDoSelected.image)
	}
	
	override class func makeCellClassIdentifiers() -> [CellClassIdentifier]
	{
		return [
			.init(cellClass: TaskCell.self, cellReuseIdentifier: "taskCell")
		]
	}
	
	override func configureDelegate()
	{
		(delegate as? TodoDelegate)?.tableView = tableView
		(delegate as? TodoDelegate)?.dayProvider = dayProvider
        (delegate as? TodoDelegate)?.database = database
	}
	
	override func configureDataSource()
	{
		(dataSource as? TodoDataSource)?.cellTextViewDelegate = self
        (dataSource as? TodoDataSource)?.database = database
        (dataSource as? TodoDataSource)?.checkBoxDelegate = self
	}
}

extension TodoController: CheckBoxDelegate {
    
    func checkBoxWillTouchUpInside(_ sender: TaskCell) {
        
        // What about the priority array?
        
        guard let task = sender.task else { return }
        guard let row = dayProvider.day.todosArray.firstIndex(of: task) else { return }
        previousRows[task] = row
    }
    
    func checkBoxDidTouchUpInside(_ sender: TaskCell) {
        
        guard let task = sender.task,
              let previousRow = previousRows[task],
              let currentRow = dayProvider.day.todosArray.firstIndex(of: task) else {
            tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            return
        }
        
        tableView.beginUpdates()
        tableView.moveRow(at: IndexPath(row: previousRow, section: 1), to: IndexPath(row: currentRow, section: 1))
        tableView.endUpdates()
    }
}
