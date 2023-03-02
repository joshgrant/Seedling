//
//  Testable.swift
//  Basic
//
//  Created by Joshua Grant on 5/30/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import Foundation

public protocol Testable
{
    func prepare()
    func test() -> Bool
    func cleanup()
}

extension Testable
{
    func prepare() {}
    func cleanup() {}
}
