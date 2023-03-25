// Copyright Team Seedling ©

import SwiftUI

class SettingsViewModel: ObservableObject
{
    var sections: [SettingsSection] = [
        .general,
        .tasks,
        .schedule,
        .extras,
        .info
    ]
}

class SettingsSection: Identifiable
{
    // MARK: - Variables
    
    var id = UUID()
    var title: String
    var items: [any SettingsCellModel]
    
    // MARK: - Initialization
    
    init(title: String, items: [any SettingsCellModel])
    {
        self.title = title
        self.items = items
    }
    
    // MARK: - Instances
    
    static let general = SettingsSection(
        title: Strings.general,
        items: [
            CheckboxCellModel(
                isOn: Settings.hideSettings,
                title: Strings.hideSettings,
                subtitle: Strings.toAccessSettings,
                action: { isOn in
                    Settings.hideSettings = isOn
                    NotificationCenter.default.post(
                        name: .hideSettingsDidToggle,
                        object: nil)
                }),
            CheckboxCellModel(
                isOn: Settings.monospacedFont,
                title: Strings.monospacedFont,
                action: { isOn in
                    Settings.monospacedFont = isOn
                    print("Should toggle 'Monospaced font'")
                }),
            CheckboxCellModel(
                isOn: Settings.lowercaseText,
                title: Strings.lowercaseText,
                action: { isOn in
                    Settings.lowercaseText = isOn
                    print("Should toggle 'Lowercase text'")
                }),
            CheckboxCellModel(
                isOn: Settings.formatNotesWithMarkdown,
                title: Strings.formatMarkdown,
                action: { isOn in
                    Settings.formatNotesWithMarkdown = isOn
                    print("Should toggle 'Format Markdown'")
                }),
            CheckboxCellModel(
                isOn: Settings.hapticFeedback,
                title: Strings.hapticFeedback,
                action: { isOn in
                    Settings.hapticFeedback = isOn
                    print("Should toggle 'Haptic feedback'")
                })
        ])
    
    static let tasks = SettingsSection(
        title: Strings.tasks,
        items: [
            CheckboxCellModel(
                isOn: Settings.automaticallyTransferTasks,
                title: Strings.automaticallyTransfer,
                action: { isOn in
                    Settings.automaticallyTransferTasks = isOn
                    print("Should toggle 'Automatically transfer'")
                }),
            TappableCellModel(
                title: Strings.editCustomSections,
                action: {
                    print("Should show the custom sections detail page")
                })
        ])
    
    static let schedule = SettingsSection(
        title: Strings.schedule,
        items: [
            SegmentedCellModel<DurationPickerOption>(
                title: Strings.sectionDuration,
                options: DurationPickerOption.allCases,
                selection: DurationPickerOption.index(from: Settings.sectionDurationMinutes),
                selectionDidChange: { selection in
                    Settings.sectionDurationMinutes = selection.duration
                    print("Updated duration selection: \(selection.title)")
                })
        ])
    
    static let extras = SettingsSection(
        title: Strings.extras,
        items: [
            CheckboxCellModel(
                isOn: Settings.pomodoroNotifications,
                title: Strings.pomodoroNotifications,
                action: { isOn in
                    Settings.pomodoroNotifications = isOn
                    print("Should toggle 'Pomodoro notifications'")
                }),
            CheckboxCellModel(
                isOn: Settings.showTotalWater,
                title: Strings.showTotalWater,
                action: { isOn in
                    Settings.showTotalWater = isOn
                    print("Should toggle 'Show total water'")
                }),
            MenuCellModel<WaterPickerOption>(
                title: Strings.waterAmount,
                options: WaterPickerOption.allCases,
                selection: WaterPickerOption.index(from: Settings.waterAmountOunces),
                selectionDidChange: { option in
                    Settings.waterAmountOunces = option.ouncesOfWater
                    print("Updated water amount selection: \(option.title)")
                })
        ])
    
    static let info = SettingsSection(
        title: Strings.info,
        items: [
            TappableCellModel(
                title: Strings.privacyPolicy,
                action: {
                    print("Should show the Privacy Policy")
                }),
            TappableCellModel(
                title: Strings.dataExport,
                action: {
                    print("Should show the share sheet that exports data")
                }),
            CenterButtonCellModel(
                title: Strings.likeTheApp,
                image: Image(systemName: "dollarsign.circle.fill"),
                action: {
                    print("Should show the tip jar sheet.")
                })
        ])
}
