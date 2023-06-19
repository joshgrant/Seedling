//
//  ScheduleController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class ScheduleController: TabContentController
{
	// MARK: - View lifecycle
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		tableView.flashScrollIndicators()
	}
	
	// MARK: - Factories
	
	override class func makeDelegate() -> TabContentDelegate
	{
		return ScheduleDelegate()
	}
	
	override class func makeDataSource(dayProvider: DayProvider) -> TabContentDataSource
	{
		return ScheduleDataSource(dayProvider: dayProvider)
	}
	
	override class func makeTabBarItem() -> UITabBarItem
	{
		return UITabBarItem(
            title: Strings.schedule.localizedCapitalized,
            image: SeedlingAsset.scheduleUnselected.image,
            selectedImage: SeedlingAsset.scheduleSelected.image)
	}
	
	override class func makeCellClassIdentifiers() -> [CellClassIdentifier]
	{
		return [
			.init(cellClass: ScheduleCell.self, cellReuseIdentifier: "scheduleCell")
		]
	}
	
	override func configureDataSource()
	{
		(dataSource as? ScheduleDataSource)?.cellTextViewDelegate = self
	}
}
