// Copyright Team Seedling ©

import SwiftUI

class SettingsController: UIHostingController<SettingsView>
{
    // MARK: - Initialization
    
    init()
    {
        super.init(rootView: SettingsView())
        
        tabBarItem = UITabBarItem(
            title: SeedlingStrings.settings,
            image: SeedlingAsset.settingsUnselected.image,
            selectedImage: SeedlingAsset.settingsSelected.image)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

struct SettingsView: View
{
    var body: some View
    {
        ScrollView
        {
            VStack
            {
                generalSection
                tasksSection
                scheduleSection
                SectionHeader(title: "Extras")
                CheckboxCellView(isOn: false, title: "Pomodoro notifications")
                CheckboxCellView(isOn: false, title: "Show total water")
                SectionHeader(title: "Info")
            }
        }
    }
    
    var generalSection: some View
    {
        VStack
        {
            SectionHeader(title: "General")
            CheckboxCellView(isOn: false, title: "Hide settings", subtitle: "To access settings, swipe right on the extras page")
            CheckboxCellView(isOn: false, title: "Monospaced font")
            CheckboxCellView(isOn: false, title: "Lowercase text")
            CheckboxCellView(isOn: false, title: "Format notes with Markdown")
            CheckboxCellView(isOn: false, title: "Haptic feedback")
        }
    }
    
    var tasksSection: some View
    {
        VStack
        {
            SectionHeader(title: "Tasks")
            CheckboxCellView(isOn: true, title: "Automatically transfer uncompleted tasks to today")
        }
    }
    
    var scheduleSection: some View
    {
        VStack
        {
            SectionHeader(title: "Schedule")
            PickerCellView()
        }
    }
}

struct SettingsView_Previews: PreviewProvider
{
    static var previews: some View
    {
        SettingsView()
    }
}
