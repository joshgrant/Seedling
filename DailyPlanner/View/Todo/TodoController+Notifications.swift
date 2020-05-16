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
		let frameEnd = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
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
		
	}
}

/*
Possibly another way of handling this:

import UIKit

public extension UIViewController
{
func startAvoidingKeyboard()
{
NotificationCenter.default
.addObserver(self,
selector: #selector(onKeyboardFrameWillChangeNotificationReceived(_:)),
name: UIResponder.keyboardWillChangeFrameNotification,
object: nil)
}

func stopAvoidingKeyboard()
{
NotificationCenter.default
.removeObserver(self,
name: UIResponder.keyboardWillChangeFrameNotification,
object: nil)
}

@objc
private func onKeyboardFrameWillChangeNotificationReceived(_ notification: Notification)
{
guard
let userInfo = notification.userInfo,
let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
else {
return
}

let keyboardFrameInView = view.convert(keyboardFrame, from: nil)
let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame.insetBy(dx: 0, dy: -additionalSafeAreaInsets.bottom)
let intersection = safeAreaFrame.intersection(keyboardFrameInView)

let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
let animationDuration: TimeInterval = (keyboardAnimationDuration as? NSNumber)?.doubleValue ?? 0
let animationCurveRawNSN = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)

UIView.animate(withDuration: animationDuration,
delay: 0,
options: animationCurve,
animations: {
self.additionalSafeAreaInsets.bottom = intersection.height
self.view.layoutIfNeeded()
}, completion: nil)
}
}

*/
