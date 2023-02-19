//
//  Accessible.swift
//  Basic
//
//  Created by Joshua Grant on 5/30/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import Foundation

public protocol Accessible
{
    var identifier: String { get }
}

public extension Accessible
{
    var identifier: String { String(describing: self) }
}
