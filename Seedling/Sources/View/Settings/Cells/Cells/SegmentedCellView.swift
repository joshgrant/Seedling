// Copyright Team Seedling ©

import SwiftUI

protocol PickerOption: Identifiable
{
    var id: Int { get }
    var title: String { get }
}

struct SegmentedCellView<Option: PickerOption> : View
{
    @State var selection: Int = 0
    
    var title: String
    var options: [Option]
    
    var body: some View
    {
        SettingsCell(title: title)
        {
            Picker(
                selection: $selection,
                label: EmptyView(), // May be an issue in Mac
                content: {
                    ForEach(options, id: \.id) { option in
                        Text(option.title).tag(option.id)
                    }
                })
            .frame(width: 150)
            .pickerStyle(.segmented)
        }
    }
}

struct SegmentedCellView_Previews: PreviewProvider
{
    enum TestOption: Int, PickerOption, CaseIterable
    {
        case fifteen
        case thirty
        case hour
        
        var id: Int { rawValue }
        var title: String
        {
            switch self
            {
            case .fifteen: return "15m"
            case .thirty: return "30m"
            case .hour: return "1hr"
            }
        }
    }
    
    static var previews: some View
    {
        SegmentedCellView(
            title: "Section duration",
            options: TestOption.allCases)
    }
}
