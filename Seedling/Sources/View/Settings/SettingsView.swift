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
    @ScaledMetric(relativeTo: .body) var iconHeight: CGFloat = 20
    @ScaledMetric(relativeTo: .body) var chevronHeight: CGFloat = 15
    
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
        Section(header: SectionHeader(title: SeedlingStrings.general))
        {
            CheckboxCellView(isOn: false, title: SeedlingStrings.hideSettings, subtitle: SeedlingStrings.toAccessSettings)
            CheckboxCellView(isOn: false, title: SeedlingStrings.monospacedFont)
            CheckboxCellView(isOn: false, title: SeedlingStrings.lowercaseText)
            CheckboxCellView(isOn: false, title: SeedlingStrings.formatMarkdown)
            CheckboxCellView(isOn: false, title: SeedlingStrings.hapticFeedback)
        }
    }
    
    var tasksSection: some View
    {
        Section(header: SectionHeader(title: SeedlingStrings.tasks))
        {
            CheckboxCellView(isOn: true, title: SeedlingStrings.automaticallyTransfer)

            TappableCellView(
                title: SeedlingStrings.editCustomSections,
                label: Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: chevronHeight),
                action: {
                    print("Edit custom sections")
                })
        }
    }
    
    var scheduleSection: some View
    {
        Section(header: SectionHeader(title: SeedlingStrings.schedule))
        {
            SegmentedCellView(title: SeedlingStrings.sectionDuration, options: SectionDuration.allCases)
        }
    }
    
    var extrasSection: some View
    {
        Section(header: SectionHeader(title: SeedlingStrings.extras))
        {
            CheckboxCellView(isOn: false, title: SeedlingStrings.pomodoroNotifications)
            CheckboxCellView(isOn: false, title: SeedlingStrings.showTotalWater)
            MenuCellView(
                title: SeedlingStrings.waterAmount,
                options: WaterAmountOption.allCases)
        }
    }
    
    var infoSection: some View
    {
        Section(header: SectionHeader(title: SeedlingStrings.info))
        {
            TappableCellView(
                title: SeedlingStrings.privacyPolicy,
                label: Image(systemName: "rectangle.portrait.and.arrow.forward")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: iconHeight),
                action: {
                    print("Privacy policy")
                })
            
            // TODO: Make these labels @ViewBuilders
            TappableCellView(
                title: SeedlingStrings.dataExport,
                label: Image(systemName: "arrow.down.doc")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: iconHeight),
                action: {
                    print("Data export")
                })
            
            CenterButtonCell(
                title: "Like the app?",
                image: Image(systemName: "dollarsign.circle.fill"),
                action: {})
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
            case .minutes15: return SeedlingStrings.m15
            case .minutes30: return SeedlingStrings.m30
            case .hour1: return SeedlingStrings.hr1
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
            case .ouncesTwo: return SeedlingStrings.ouncesAmount(2)
            case .ouncesFour: return SeedlingStrings.ouncesAmount(4)
            case .ouncesSix: return SeedlingStrings.ouncesAmount(6)
            case .ouncesEight: return SeedlingStrings.ouncesAmount(8)
            case .ouncesTwelve: return SeedlingStrings.ouncesAmount(12)
            case .ouncesTwentyFour: return SeedlingStrings.ouncesAmount(24)
            case .ouncesThirtyTwo: return SeedlingStrings.ouncesAmount(32)
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
