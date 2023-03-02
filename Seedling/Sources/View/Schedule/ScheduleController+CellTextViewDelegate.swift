//
//  ScheduleController+CellTextViewDelegate.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

extension ScheduleController: CellTextViewDelegate {
	
	func textViewDidBeginEditing(_ textView: UITextView, in cell: UITableViewCell) {
		//
	}
	
	func textViewDidChange(_ textView: UITextView, in cell: UITableViewCell) {
		tableView.performBatchUpdates({
			UIView.animate(withDuration: 0.0) {
				cell.contentView.setNeedsLayout()
				cell.contentView.layoutIfNeeded()
			}
		}, completion: nil)
	}
	
	func textViewDidEndEditing(_ textView: UITextView, in cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let array = dayProvider.day.schedulesArray
            let schedule = array[indexPath.row]
			schedule.content = textView.text
            database.save()
		}
		textView.resignFirstResponder()
	}
	
	func textViewShouldReturn(_ textView: UITextView, in cell: UITableViewCell) -> Bool {
		return true
	}
}
