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
            LazyVStack(spacing: 0, pinnedViews: .sectionHeaders)
            {
                generalSection
                tasksSection
                scheduleSection
                extrasSection
                infoSection
            }
        }
    }
    
    var generalSection: some View
    {
        Section(header: SectionHeader(title: "General"))
        {
            CheckboxCellView(isOn: false, title: "Hide settings", subtitle: "To access settings, swipe right on the extras page")
            CheckboxCellView(isOn: false, title: "Monospaced font")
            CheckboxCellView(isOn: false, title: "Lowercase text")
            CheckboxCellView(isOn: false, title: "Format notes with Markdown")
            CheckboxCellView(isOn: false, title: "Haptic feedback")
        }
    }
    
    var tasksSection: some View
    {
        Section(header: SectionHeader(title: "Tasks"))
        {
            CheckboxCellView(isOn: true, title: "Automatically transfer uncompleted tasks to today")

            TappableCellView(
                title: "Edit custom sections",
                label: Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 15),
                action: {
                    print("Edit custom sections")
                })
        }
    }
    
    var scheduleSection: some View
    {
        Section(header: SectionHeader(title: "Schedule"))
        {
            SegmentedCellView(title: "Section duration", options: SectionDuration.allCases)
        }
    }
    
    var extrasSection: some View
    {
        Section(header: SectionHeader(title: "Extras"))
        {
            CheckboxCellView(isOn: false, title: "Pomodoro notifications")
            CheckboxCellView(isOn: false, title: "Show total water")
            MenuCellView(
                title: "Water amount",
                options: WaterAmountOption.allCases)
        }
    }
    
    var infoSection: some View
    {
        Section(header: SectionHeader(title: "Info"))
        {
            TappableCellView(
                title: "Privacy policy",
                label: Image(systemName: "rectangle.portrait.and.arrow.forward")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20),
                action: {
                    print("Privacy policy")
                })
            
            // TODO: Make these labels @ViewBuilders
            TappableCellView(
                title: "Data export",
                label: Image(systemName: "arrow.down.doc")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20),
                action: {
                    print("Data export")
                })
        }
    }
}

extension SettingsView
{
    // MARK: - Types
    
    enum SectionDuration: Int, CaseIterable, PickerOption
    {
        case minutes15
        case minutes30
        case hour1
        
        var id: Int { rawValue }
        
        var title: String
        {
            switch self
            {
            case .minutes15: return "15m"
            case .minutes30: return "30m"
            case .hour1: return "1hr"
            }
        }
    }
    
    enum WaterAmountOption: Int, CaseIterable, PickerOption
    {
        case ouncesTwo
        case ouncesFour
        case ouncesSix
        case ouncesEight
        case ouncesTwelve
        case ouncesTwentyFour
        case ouncesThirtyTwo
        
        var id: Int { rawValue }
        
        var title: String
        {
            switch self
            {
            case .ouncesTwo: return "2oz"
            case .ouncesFour: return "4oz"
            case .ouncesSix: return "6oz"
            case .ouncesEight: return "8oz"
            case .ouncesTwelve: return "12oz"
            case .ouncesTwentyFour: return "24oz"
            case .ouncesThirtyTwo: return "32oz"
            }
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
