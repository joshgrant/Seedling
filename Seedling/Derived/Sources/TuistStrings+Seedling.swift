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
  /// breakfast
  public static let breakfast = SeedlingStrings.tr("Localizable", "breakfast")
  /// checked
  public static let checked = SeedlingStrings.tr("Localizable", "checked")
  /// dinner
  public static let dinner = SeedlingStrings.tr("Localizable", "dinner")
  /// extras
  public static let extras = SeedlingStrings.tr("Localizable", "extras")
  /// d MMM
  public static let formatDayMonth = SeedlingStrings.tr("Localizable", "format_day_month")
  /// EEEE, d MMM
  public static let formatWeekdayDayMonth = SeedlingStrings.tr("Localizable", "format_weekday_day_month")
  /// lunch
  public static let lunch = SeedlingStrings.tr("Localizable", "lunch")
  /// meals
  public static let meals = SeedlingStrings.tr("Localizable", "meals")
  /// notes
  public static let notes = SeedlingStrings.tr("Localizable", "notes")
  /// pomodoro
  public static let pomodoro = SeedlingStrings.tr("Localizable", "pomodoro")
  /// priorities
  public static let priorities = SeedlingStrings.tr("Localizable", "priorities")
  /// privacy policy
  public static let privacyPolicy = SeedlingStrings.tr("Localizable", "privacy_policy")
  /// https://bloomingthyme.com/?page_id=168
  public static let privacyPolicyUrl = SeedlingStrings.tr("Localizable", "privacy_policy_url")
  /// schedule
  public static let schedule = SeedlingStrings.tr("Localizable", "schedule")
  /// to do
  public static let toDo = SeedlingStrings.tr("Localizable", "to do")
  /// today, %@
  public static func today(_ p1: Any) -> String {
    return SeedlingStrings.tr("Localizable", "today", String(describing: p1))
  }
  /// unchecked
  public static let unchecked = SeedlingStrings.tr("Localizable", "unchecked")
  /// water
  public static let water = SeedlingStrings.tr("Localizable", "water")
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
