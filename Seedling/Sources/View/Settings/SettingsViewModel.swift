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
                isOn: false,
                title: Strings.hideSettings,
                subtitle: Strings.toAccessSettings,
                action: { isOn in
                    print("Should toggle 'Hide settings'")
                }),
            CheckboxCellModel(
                isOn: false,
                title: Strings.monospacedFont,
                action: { isOn in
                    print("Should toggle 'Monospaced font'")
                }),
            CheckboxCellModel(
                isOn: false,
                title: Strings.lowercaseText,
                action: { isOn in
                    print("Should toggle 'Lowercase text'")
                }),
            CheckboxCellModel(
                isOn: false,
                title: Strings.formatMarkdown,
                action: { isOn in
                    print("Should toggle 'Format Markdown'")
                }),
            CheckboxCellModel(
                isOn: false,
                title: Strings.hapticFeedback,
                action: { isOn in
                    print("Should toggle 'Haptic feedback'")
                })
        ])
    
    static let tasks = SettingsSection(
        title: Strings.tasks,
        items: [
            CheckboxCellModel(
                isOn: false,
                title: Strings.automaticallyTransfer,
                action: { isOn in
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
            SegmentedCellModel(
                title: Strings.sectionDuration,
                options: PickerOption.durations,
                selectionDidChange: { selection in
                    print("Updated duration selection: \(selection.title)")
                })
        ])
    
    static let extras = SettingsSection(
        title: Strings.extras,
        items: [
            CheckboxCellModel(
                isOn: false,
                title: Strings.pomodoroNotifications,
                action: { isOn in
                    print("Should toggle 'Pomodoro notifications'")
                }),
            CheckboxCellModel(
                isOn: false,
                title: Strings.showTotalWater,
                action: { isOn in
                    print("Should toggle 'Show total water'")
                }),
            MenuCellModel(
                title: Strings.waterAmount,
                options: PickerOption.waterAmounts,
                selectionDidChange: { option in
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
