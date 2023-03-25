// Copyright Team Seedling ©

import Foundation

@propertyWrapper struct UbiquitousBool
{
    let key: String
    let defaultValue: Bool
    var store: NSUbiquitousKeyValueStore = .default
    
    var wrappedValue: Bool {
        get
        {
            if let number = store.object(forKey: key) as? NSNumber
            {
                return number.boolValue
            }
            else
            {
                return defaultValue
            }
        }
        set
        {
            let newNumber = NSNumber(booleanLiteral: newValue)
            store.set(newNumber, forKey: key)
            
        }
    }
}

@propertyWrapper struct UbiquitousInt
{
    let key: String
    let defaultValue: Int
    var store: NSUbiquitousKeyValueStore = .default
    
    var wrappedValue: Int {
        get {
            if let number = store.object(forKey: key) as? NSNumber
            {
                return number.intValue
            }
            else
            {
                return defaultValue
            }
        }
        set
        {
            let newNumber = NSNumber(integerLiteral: newValue)
            store.set(newNumber, forKey: key)
        }
    }
}

class Settings
{
    @UbiquitousBool(key: "hide-settings", defaultValue: false)
    static var hideSettings
    
    @UbiquitousBool(key: "monospaced-font", defaultValue: true)
    static var monospacedFont
    
    @UbiquitousBool(key: "lowercase-text", defaultValue: false)
    static var lowercaseText
    
    @UbiquitousBool(key: "format-notes-with-markdown", defaultValue: true)
    static var formatNotesWithMarkdown
    
    @UbiquitousBool(key: "haptic-feedback", defaultValue: true)
    static var hapticFeedback
    
    @UbiquitousBool(key: "automatically-transfer-tasks", defaultValue: false)
    static var automaticallyTransferTasks
    
    /// Either 15, 30, or 60 with the option to expand in the future if necessary
    @UbiquitousInt(key: "section-duration-minutes", defaultValue: 60)
    static var sectionDurationMinutes
    
    @UbiquitousBool(key: "pomodoro-notifications", defaultValue: false)
    static var pomodoroNotifications
    
    @UbiquitousBool(key: "show-total-water", defaultValue: false)
    static var showTotalWater
    
    /// Either 1, 2, 4, or 8 with the option to expand
    @UbiquitousInt(key: "water-amount-ounces", defaultValue: 8)
    static var waterAmountOunces
}
