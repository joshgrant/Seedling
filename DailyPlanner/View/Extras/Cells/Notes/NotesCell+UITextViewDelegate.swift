//
//  NotesCell+UITextViewDelegate.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

extension NotesCell: UITextViewDelegate {
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		delegate?.textViewDidBeginEditing(textView, in: self)
	}
	
	func textViewDidChange(_ textView: UITextView) {
		delegate?.textViewDidChange(textView, in: self)
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		self.note?.content = textView.text
		Database.save()
		delegate?.textViewDidEndEditing(textView, in: self)
	}
}
