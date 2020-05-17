//
//  ExtrasController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class ExtrasController: TabContentController
{
	// MARK: - Initialization
	
	override init?(dayProvider: DayProvider)
	{
		super.init(dayProvider: dayProvider)
		
		configureDataSource()
	}
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	// MARK: - Factory
	
	override class func makeDelegate() -> TabContentDelegate
	{
		return ExtrasDelegate()
	}
	
	override class func makeDataSource(dayProvider: DayProvider) -> TabContentDataSource
	{
		return ExtrasDataSource(dayProvider: dayProvider)
	}
	
	override class func makeTableView() -> UITableView
	{
		return UITableView()
	}
	
	override class func makeTabBarItem() -> UITabBarItem {
		return UITabBarItem(
			title: "Extras",
			image: .type(.extras),
			selectedImage: .type(.extrasSelected))
	}
	
	override class func makeCellClassIdentifiers() -> [CellClassIdentifier]
	{
		return [
			.init(cellClass: MealsCell.self, cellReuseIdentifier: "mealsCell"),
			.init(cellClass: WaterCell.self, cellReuseIdentifier: "waterCell"),
			.init(cellClass: PomodoroCell.self, cellReuseIdentifier: "pomodoroCell"),
			.init(cellClass: NotesCell.self, cellReuseIdentifier: "notesCell")
		]
	}
	
	// MARK: - Configuration
	
	override func configureDataSource()
	{
		(dataSource as? ExtrasDataSource)?.cellTextViewDelegate = self
	}
}

extension ExtrasController: CellTextViewDelegate
{
	func textViewDidBeginEditing(_ textView: UITextView, in cell: UITableViewCell)
	{
		
	}
	
	func textViewDidChange(_ textView: UITextView, in cell: UITableViewCell)
	{
		tableView.performBatchUpdates({
			UIView.animate(withDuration: 0.0) {
				cell.contentView.setNeedsLayout()
				cell.contentView.layoutIfNeeded()
			}
		}, completion: nil)
	}
	
	func textViewDidEndEditing(_ textView: UITextView, in cell: UITableViewCell)
	{
		
	}
	
	func textViewShouldReturn(_ textView: UITextView, in cell: UITableViewCell) -> Bool
	{
		textView.resignFirstResponder()
		return true
	}
}
