//
//  TodoController+Notifications.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/9/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

extension TodoController
{
	func handleNotifications()
	{
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(dayProviderDidUpdateDay(_:)),
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
		// Perhaps a better way?
	}
	
	@objc func keyboardWillShow(_ notification: Notification)
	{
		let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
		let animationCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int
		let frameEnd = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
		
		UIView.animate(withDuration: duration ?? 0, delay: 0, options: .init(rawValue: UInt(animationCurve ?? 0)), animations: {
			self.tableView.contentInset.bottom = frameEnd?.height ?? 0
		}, completion: nil)
	}
	
	@objc func keyboardDidShow(_ notification: Notification)
	{
		
	}
	
	@objc func keyboardWillHide(_ notification: Notification)
	{
		let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
		let animationCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int
		//        let frameEnd = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
		
		UIView.animate(withDuration: duration ?? 0, delay: 0, options: .init(rawValue: UInt(animationCurve ?? 0)), animations: {
			self.tableView.contentInset.bottom = 0
		}, completion: nil)
	}
	
	@objc func keyboardDidHide(_ notification: Notification)
	{
		
	}
}
