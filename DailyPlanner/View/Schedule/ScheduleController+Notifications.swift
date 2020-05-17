//
//  ScheduleController+Notifications.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/16/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

extension ScheduleController
{
	func handleNotifications()
	{
		NotificationCenter.default.addObserver(
			self, selector: #selector(dayProviderDidUpdateDay(_:)),
			name: .dayProviderDidUpdateDay,
			object: nil)
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillShow(_:)),
			name: UIResponder.keyboardWillShowNotification,
			object: nil)
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardDidShow(_:)),
			name: UIResponder.keyboardDidShowNotification,
			object: nil)
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillHide(_:)),
			name: UIResponder.keyboardWillHideNotification,
			object: nil)
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardDidHide(_:)),
			name: UIResponder.keyboardDidHideNotification,
			object: nil)
	}
	
	@objc func dayProviderDidUpdateDay(_ notification: Notification)
	{
		tableView.reloadData()
	}
	
	@objc func keyboardWillShow(_ notification: Notification)
	{
		let frameEnd = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
		let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
		let animationCurve: UIView.AnimationCurve
		if let ac = (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue, let curve = UIView.AnimationCurve(rawValue: ac) {
			animationCurve = curve
		} else {
			fatalError()
		}
		
		UIViewPropertyAnimator(duration: duration ?? 0, curve: animationCurve) {
			let insets = UIEdgeInsets(top: 0, left: 0, bottom: frameEnd?.height ?? 0, right: 0)
			self.tableView.contentInset = insets
			self.tableView.verticalScrollIndicatorInsets = insets
		}.startAnimation()
	}
	
	@objc func keyboardDidShow(_ notification: Notification)
	{
		
	}
	
	@objc func keyboardWillHide(_ notification: Notification)
	{
//		let frameEnd = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
		let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
		let animationCurve: UIView.AnimationCurve
		
		if let ac = (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue, let curve = UIView.AnimationCurve(rawValue: ac) {
			animationCurve = curve
		} else {
			fatalError()
		}
		
			UIViewPropertyAnimator(duration: duration ?? 0, curve: animationCurve) {
				let insets = UIEdgeInsets.zero
				self.tableView.contentInset = insets
				self.tableView.verticalScrollIndicatorInsets = insets
			}.startAnimation()

	}
	
	@objc func keyboardDidHide(_ notification: Notification)
	{
//		print(notification)
	}
	
//	func keyboardWillShowNotification(notification: Notification) {
//		let userInfo = notification.userInfo!
//		let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//		let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
//		self.tableView.contentInset = contentInsets
//		self.tableView.scrollIndicatorInsets = contentInsets
//
//		var rect = self.view.frame
//		rect.size.height -= keyboardSize.height
//		if let activeTextField = activeTextField, !rect.contains(activeTextField.frame.origin) {
//			self.tableView.scrollRectToVisible(activeTextField.frame, animated: true)
//		}
//	}
//
//	func keyboardWillHideNotification(notification: Notification) {
//		let contentInsets = UIEdgeInsets.zero
//		self.tableView.contentInset = contentInsets
//		self.tableView.scrollIndicatorInsets = contentInsets
//	}
}
