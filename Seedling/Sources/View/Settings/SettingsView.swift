// Copyright Team Seedling ©

import SwiftUI

typealias Strings = SeedlingStrings // TODO: Move this

struct SettingsView: View
{
    // MARK: - Variables
    
    @ScaledMetric(relativeTo: .body) var iconHeight: CGFloat = 20
    @ScaledMetric(relativeTo: .body) var chevronHeight: CGFloat = 15
    @ObservedObject var model: SettingsViewModel
    
    // MARK: - View
    
    var body: some View
    {
        ScrollView
        {
            LazyVStack(spacing: 0, pinnedViews: .sectionHeaders)
            {
                ForEach(model.sections, id: \.id) { section in
                    Section(header: SectionHeader(title: section.title)) {
                        ForEach(section.items, id: \.id) { item in
                            switch item
                            {
                            case let model as CheckboxCellModel:
                                CheckboxCellView(model: model)
                            case let model as TappableCellModel:
                                TappableCellView(model: model) {
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: chevronHeight)
                                }
                            case let model as SegmentedCellModel:
                                SegmentedCellView(model: model)
                            case let model as MenuCellModel:
                                MenuCellView(model: model)
                            case let model as CenterButtonCellModel:
                                CenterButtonCellView(model: model)
                            default:
                                EmptyView()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider
{
    struct SettingsView_Shim: View
    {
        var model: SettingsViewModel
        
        var body: some View
        {
            SettingsView(model: model)
        }
    }
    
    static var previews: some View
    {
        SettingsView_Shim(model: .init())
    }
}
