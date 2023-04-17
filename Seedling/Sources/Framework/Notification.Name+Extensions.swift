// Copyright Team Seedling ©

import Foundation

extension Notification.Name
{
    // MARK: - Settings notifications
    
    static let requestShowSettings = Notification.Name("requestShowSettings")
    static let requestHideSettings = Notification.Name("requestHideSettings")
    static let monospacedFontDidToggle = Notification.Name("monospacedFontDidToggle")
    static let lowercaseTextDidToggle = Notification.Name("lowercaseTextDidToggle")
    static let formatNotesWithMarkdownDidToggle = Notification.Name("formatNotesWithMarkdownDidToggle")
    static let hapticFeedbackDidToggle = Notification.Name("hapticFeedbackDidToggle")
}
