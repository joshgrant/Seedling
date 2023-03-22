// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum SeedlingStrings {
  /// Automatically transfer uncompleted tasks to today
  public static let automaticallyTransfer = SeedlingStrings.tr("Localizable", "automatically_transfer")
  /// Breakfast
  public static let breakfast = SeedlingStrings.tr("Localizable", "breakfast")
  /// Checked
  public static let checked = SeedlingStrings.tr("Localizable", "checked")
  /// Data export
  public static let dataExport = SeedlingStrings.tr("Localizable", "data_export")
  /// Dinner
  public static let dinner = SeedlingStrings.tr("Localizable", "dinner")
  /// Edit custom sections
  public static let editCustomSections = SeedlingStrings.tr("Localizable", "edit_custom_sections")
  /// Extras
  public static let extras = SeedlingStrings.tr("Localizable", "extras")
  /// d MMM
  public static let formatDayMonth = SeedlingStrings.tr("Localizable", "format_day_month")
  /// Format notes with Markdown
  public static let formatMarkdown = SeedlingStrings.tr("Localizable", "format_markdown")
  /// EEEE, d MMM
  public static let formatWeekdayDayMonth = SeedlingStrings.tr("Localizable", "format_weekday_day_month")
  /// General
  public static let general = SeedlingStrings.tr("Localizable", "general")
  /// Haptic feedback
  public static let hapticFeedback = SeedlingStrings.tr("Localizable", "haptic_feedback")
  /// Hide settings
  public static let hideSettings = SeedlingStrings.tr("Localizable", "hide_settings")
  /// 1hr
  public static let hr1 = SeedlingStrings.tr("Localizable", "hr1")
  /// Info
  public static let info = SeedlingStrings.tr("Localizable", "info")
  /// Lowercase text
  public static let lowercaseText = SeedlingStrings.tr("Localizable", "lowercase_text")
  /// Lunch
  public static let lunch = SeedlingStrings.tr("Localizable", "lunch")
  /// 15m
  public static let m15 = SeedlingStrings.tr("Localizable", "m15")
  /// 30m
  public static let m30 = SeedlingStrings.tr("Localizable", "m30")
  /// Meals
  public static let meals = SeedlingStrings.tr("Localizable", "meals")
  /// Monospaced font
  public static let monospacedFont = SeedlingStrings.tr("Localizable", "monospaced_font")
  /// Notes
  public static let notes = SeedlingStrings.tr("Localizable", "notes")
  /// %@oz
  public static func ouncesAmount(_ p1: Any) -> String {
    return SeedlingStrings.tr("Localizable", "ounces_amount", String(describing: p1))
  }
  /// Pomodoro
  public static let pomodoro = SeedlingStrings.tr("Localizable", "pomodoro")
  /// Pomodoro notifications
  public static let pomodoroNotifications = SeedlingStrings.tr("Localizable", "pomodoro_notifications")
  /// Priorities
  public static let priorities = SeedlingStrings.tr("Localizable", "priorities")
  /// Privacy policy
  public static let privacyPolicy = SeedlingStrings.tr("Localizable", "privacy_policy")
  /// https://bloomingthyme.com/?page_id=168
  public static let privacyPolicyUrl = SeedlingStrings.tr("Localizable", "privacy_policy_url")
  /// Schedule
  public static let schedule = SeedlingStrings.tr("Localizable", "schedule")
  /// Section duration
  public static let sectionDuration = SeedlingStrings.tr("Localizable", "section_duration")
  /// Settings
  public static let settings = SeedlingStrings.tr("Localizable", "settings")
  /// Show total water
  public static let showTotalWater = SeedlingStrings.tr("Localizable", "show_total_water")
  /// Tasks
  public static let tasks = SeedlingStrings.tr("Localizable", "tasks")
  /// To do
  public static let toDo = SeedlingStrings.tr("Localizable", "to do")
  /// To access settings, swipe right on the extras page
  public static let toAccessSettings = SeedlingStrings.tr("Localizable", "to_access_settings")
  /// Today, %@
  public static func today(_ p1: Any) -> String {
    return SeedlingStrings.tr("Localizable", "today", String(describing: p1))
  }
  /// Unchecked
  public static let unchecked = SeedlingStrings.tr("Localizable", "unchecked")
  /// Water
  public static let water = SeedlingStrings.tr("Localizable", "water")
  /// Water amount
  public static let waterAmount = SeedlingStrings.tr("Localizable", "water_amount")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension SeedlingStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = SeedlingResources.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
