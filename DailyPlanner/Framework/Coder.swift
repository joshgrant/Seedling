//
//  Coder.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import Foundation

class Coder: NSCoder {
    
    override var allowsKeyedCoding: Bool { true }
    
    override func containsValue(forKey key: String) -> Bool { false }
    
    override func encode(_ object: Any?, forKey key: String) { }
    override func decodeObject(forKey key: String) -> Any? { nil }
    
    override func encode(_ value: Bool, forKey key: String) { }
    override func decodeBool(forKey key: String) -> Bool { false }
    
    override func encode(_ data: Data) { }
    override func decodeData() -> Data? { nil }
    
    override func encodeValue(ofObjCType type: UnsafePointer<Int8>, at addr: UnsafeRawPointer) { }
    override func decodeValue(ofObjCType type: UnsafePointer<Int8>, at data: UnsafeMutableRawPointer) { }
    
    override func encode(_ value: Int64, forKey key: String) { }
    override func decodeInt64(forKey key: String) -> Int64 { 0 }
    
    override func version(forClassName className: String) -> Int { 0 }
}
