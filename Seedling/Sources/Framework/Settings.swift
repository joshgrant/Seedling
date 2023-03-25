// Copyright Team Seedling ©

import Foundation

@propertyWrapper struct Ubiquitous<Value>
{
    let key: String
    var store: NSUbiquitousKeyValueStore = .default
    
    var wrappedValue: Value? {
        get { store.value(forKey: key) as? Value }
        set { store.setValue(newValue, forKey: key) }
    }
}

class Settings
{
    @Ubiquitous<Bool>(key: "hide-settings")
    static var hideSettings
    
    @Ubiquitous<Bool>(key: "monospaced-font")
    static var monospacedFont
    
    @Ubiquitous<Bool>(key: "lowercase-text")
    static var lowercaseText
    
    @Ubiquitous<Bool>(key: "format-notes-with-markdown")
    static var formatNotesWithMarkdown
    
    @Ubiquitous<Bool>(key: "haptic-feedback")
    static var hapticFeedback
    
    @Ubiquitous<Bool>(key: "automatically-transfer-tasks")
    static var automaticallyTransferTasks

    @Ubiquitous<[String]>(key: "custom-sections")
    static var customSections
    
    /// Either 15, 30, or 60 with the option to expand in the future if necessary
    @Ubiquitous<[Int]>(key: "section-duration-minutes")
    static var sectionDurationMinutes
    
    @Ubiquitous<Bool>(key: "pomodoro-notifications")
    static var pomodoroNotifications
    
    @Ubiquitous<Bool>(key: "show-total-water")
    static var showTotalWater
    
    /// Either 1, 2, 4, or 8 with the option to expand
    @Ubiquitous<[Int]>(key: "water-amount-ounces")
    static var waterAmountOunces
}
