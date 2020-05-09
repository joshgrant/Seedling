//
//  CellTextViewDelegate.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

protocol CellTextViewDelegate: class {
	func textViewDidBeginEditing(_ textView: UITextView, in cell: UITableViewCell)
	func textViewDidChange(_ textView: UITextView, in cell: UITableViewCell)
	func textViewDidEndEditing(_ textView: UITextView, in cell: UITableViewCell)
	func textViewShouldReturn(_ textView: UITextView, in cell: UITableViewCell) -> Bool
}
