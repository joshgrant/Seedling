// Copyright Team Seedling ©

import XCTest

extension XCUIElement
{
    func clear(function: StaticString = #function, line: UInt = #line)
    {
        guard value is String else
        {
            XCTFail("Can't clear text with an element that doesn't have a String value.")
            return
        }
        
        while let stringValue = value as? String, !stringValue.isEmpty, stringValue != placeholderValue
        {
            let lowerRightCorner = coordinate(withNormalizedOffset: .init(dx: 0.9, dy: 0.9))
            lowerRightCorner.tap()
            let delete = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
            self.typeText(delete)
        }
    }
    
    func clearAndTypeText(_ text: String, function: StaticString = #function, line: UInt = #line)
    {
        clear(function: function, line: line)
        typeText(text)
    }
}
