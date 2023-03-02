//
//  KeyboardNotification.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

struct KeyboardNotification
{
	// MARK: - Variables
	
	var duration: TimeInterval
	var animationCurve: UIView.AnimationCurve
	
	var frameBegin: CGRect
	var frameEnd: CGRect
	
	var isLocal: Bool
	
	// MARK: - Initialization
	
	init?(notification: Notification)
	{
		guard let userInfo = notification.userInfo else { return nil }
		
		guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else
		{
			return nil
		}
		
		guard let animationCurveRaw = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue, let animationCurve = UIView.AnimationCurve(rawValue: animationCurveRaw) else
		{
			return nil
		}
		
		guard let frameBegin = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect else
		{
			return nil
		}
		
		guard let frameEnd = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else
		{
			return nil
		}
		
		guard let isLocal = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? Bool else
		{
			return nil
		}
		
		self.duration = duration
		self.animationCurve = animationCurve
		self.frameBegin = frameBegin
		self.frameEnd = frameEnd
		self.isLocal = isLocal
	}
}
