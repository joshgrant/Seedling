//
//  Entity+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import Foundation
import CoreData

extension Entity
{
    var wrappedCreatedDate: Date
	{
        return createdDate ?? Date()
    }
	
    @objc class var defaultSortDescriptors: [NSSortDescriptor] {
		return [NSSortDescriptor(keyPath: \Entity.createdDate, ascending: true)]
	}
}
