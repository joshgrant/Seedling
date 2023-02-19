//
//  KeyboardNotification+CustomStringConvertible.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/17/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import Foundation

extension KeyboardNotification: CustomStringConvertible
{
	var durationDescription: String
	{
		return "Duration: \(duration)"
	}
	
	var animationCurveDescription: String
	{
		return "Curve: \(animationCurve.rawValue)"
	}
	
	var frameBeginDescription: String
	{
		return "Begin: \(frameBegin)"
	}
	
	var frameEndDescription: String
	{
		return "End: \(frameEnd)"
	}
	
	var isLocalDescription: String
	{
		return "Is Local: \(isLocal)"
	}
	
	var description: String
	{
		return [
			durationDescription,
			animationCurveDescription,
			frameBeginDescription,
			frameEndDescription,
			isLocalDescription
			].reduce("") { (result, string) -> String in
				return result.appending(string).appending("\n")
		}
	}
}
