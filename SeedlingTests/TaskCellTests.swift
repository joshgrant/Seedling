//
//  TaskCellTests.swift
//  SeedlingTests
//
//  Created by Jesse Vernon on 10/10/22.
//

import XCTest
@testable import Seedling

final class TaskCellTests: XCTestCase
{
    //editing when you tap on the text field
    //check the cell
    //uncheck the cell
    //entering long text should make the cell taller
    //swipe left to show the trash icon
    //tapping on the trash icon deletes text
    //checkbox should be centered if there are multiple lines
    
    func test_assigningCheckedUpdatesValue()
    {
        let model = TaskCellModel(checked: true)
        let taskCell = TaskCell(model: model)
        taskCell.checked = false
        XCTAssertEqual(taskCell.checked, false)
        taskCell.checked = true
        XCTAssertEqual(taskCell.checked, true)
    }
    

    func test_tappingOnUncheckedMakeCheck()
    {
        let taskCell = TaskCell()
        taskCell.checked = false
        XCTAssertEqual(taskCell.checked,false)
    }
}

