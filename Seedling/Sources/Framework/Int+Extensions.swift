//
//  Int+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 9/6/22.
//  Copyright © 2022 Joshua Grant. All rights reserved.
//

import Foundation

public extension SignedInteger
{
    func convert24HourTimeToTwelveHourTime() -> Self
    {
        let convertedValue = self % 12
        
        if convertedValue == 0
        {
            return 12
        }
        else
        {
            return convertedValue
        }
    }
}
