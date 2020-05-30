//
//  MealsCell+UITextViewDelegate.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

extension MealsCell: UITextViewDelegate
{
	func textViewDidBeginEditing(_ textView: UITextView)
	{
		delegate?.textViewDidBeginEditing(textView, in: self)
	}
	
	func textViewDidChange(_ textView: UITextView)
	{
		delegate?.textViewDidChange(textView, in: self)
	}
	
	func textViewDidEndEditing(_ textView: UITextView)
	{
        // TODO: Not ideal that we're performing database
        // operations in the cell... This should be forwarded to the controller..
		delegate?.textViewDidEndEditing(textView, in: self)
        database?.context.perform {
			switch textView {
			case self.breakfastTextView:
				self.meal?.breakfast = textView.text
			case self.lunchTextView:
				self.meal?.lunch = textView.text
			case self.dinnerTextView:
				self.meal?.dinner = textView.text
			default:
				break
			}
            self.database?.save()
		}
	}
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
	{
		if text == "\n", delegate?.textViewShouldReturn(textView, in: self) ?? false
		{
			return false
		}
		else
		{
			return true
		}
	}
}
