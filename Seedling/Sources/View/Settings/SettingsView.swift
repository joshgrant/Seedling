// Copyright Team Seedling ©

import SwiftUI

class SettingsController: UIHostingController<AnyView>
{
    // MARK: - Initialization
    
    init(context: Context)
    {
        let rootView = SettingsView()
            .environment(\.managedObjectContext, context)
        
        // TODO: Context for some reason is failing here
        ///Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '+entityForName: nil is not a legal NSPersistentStoreCoordinator for searching for entity name 'MealType''
        let anyView = AnyView(rootView)
        super.init(rootView: anyView)
        
        tabBarItem = UITabBarItem(
            title: Strings.settings,
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
    
    @Environment(\.managedObjectContext) var context
    
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
        .environment(\.managedObjectContext, context)
    }
    
    var generalSection: some View
    {
        Section(header: SectionHeader(title: Strings.general))
        {
            CheckboxCellView(isOn: false, title: Strings.hideSettings, subtitle: Strings.toAccessSettings)
            CheckboxCellView(isOn: false, title: Strings.monospacedFont)
            CheckboxCellView(isOn: false, title: Strings.lowercaseText)
            CheckboxCellView(isOn: false, title: Strings.formatMarkdown)
            CheckboxCellView(isOn: false, title: Strings.hapticFeedback)
        }
    }
    
    var tasksSection: some View
    {
        Section(header: SectionHeader(title: Strings.tasks))
        {
            TappableCellView(
                title: Strings.editSections,
                label: Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: chevronHeight),
                destination: {
                    EntityListEditView<TaskSection>(configuration: .taskSection) { context in
                        let numberOfSections = TaskSection.allSections(in: context).count
                        let newTaskSection = TaskSection(context: context)
                        newTaskSection.sortIndex = Int32(numberOfSections + 1)
                        try! context.save()
                        return newTaskSection
                    }
                    .environment(\.managedObjectContext, context)
                })
            
            CheckboxCellView(isOn: true, title: Strings.automaticallyTransfer)
        }
    }
    
    var scheduleSection: some View
    {
        Section(header: SectionHeader(title: Strings.schedule))
        {
            SegmentedCellView(title: Strings.sectionDuration, options: SectionDuration.allCases)
        }
    }
    
    var extrasSection: some View
    {
        Section(header: SectionHeader(title: Strings.extras))
        {
            TappableCellView(
                title: Strings.editMealTypes,
                label: Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: chevronHeight),
                destination: {
                    EntityListEditView<MealType>(configuration: .mealType) { context in
                        let numberOfMeals = try! MealType.totalCount(in: context)
                        let newMeal = MealType(context: context)
                        newMeal.sortIndex = Int32(numberOfMeals + 1)
                        try! context.save()
                        return newMeal
                    }
                    .environment(\.managedObjectContext, context)
                })
            
            CheckboxCellView(isOn: false, title: Strings.pomodoroNotifications)
            CheckboxCellView(isOn: false, title: Strings.showTotalWater)
            
            MenuCellView(
                title: Strings.waterAmount,
                options: WaterAmountOption.allCases)
        }
    }
    
    var infoSection: some View
    {
        Section(header: SectionHeader(title: Strings.info))
        {
            TappableCellView(
                title: Strings.privacyPolicy,
                label: Image(systemName: "rectangle.portrait.and.arrow.forward")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: iconHeight),
                destination: {
                    SettingsCell(title: "Privacy Policy", label: { Text("This should be the privacy policy view") })
                })
            
            // TODO: Make these labels @ViewBuilders
            TappableCellView(
                title: Strings.dataExport,
                label: Image(systemName: "arrow.down.doc")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: iconHeight),
                destination: {
                    SettingsCell(title: "Data Export", label: { Text("This should be the data export view") })
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
            case .minutes15: return Strings.m15
            case .minutes30: return Strings.m30
            case .hour1: return Strings.hr1
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
            case .ouncesTwo: return Strings.ouncesAmount(2)
            case .ouncesFour: return Strings.ouncesAmount(4)
            case .ouncesSix: return Strings.ouncesAmount(6)
            case .ouncesEight: return Strings.ouncesAmount(8)
            case .ouncesTwelve: return Strings.ouncesAmount(12)
            case .ouncesTwentyFour: return Strings.ouncesAmount(24)
            case .ouncesThirtyTwo: return Strings.ouncesAmount(32)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider
{
    static let database = Database(containerName: "Seedling")
    
    static var previews: some View
    {
        NavigationStack {
            SettingsView()
                .environment(\.managedObjectContext, database.context)
        }
        .tint(SeedlingAsset.orange.swiftUIColor)
    }
}
