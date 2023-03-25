// Copyright Team Seedling ©

import SwiftUI

struct SegmentedCellView<Option: PickerOption>: View
{
    @ObservedObject var model: SegmentedCellModel<Option>
    
    var body: some View
    {
        SettingsCell(title: model.title)
        {
            Picker(
                selection: $model.selection,
                label: EmptyView(), // May be an issue in Mac
                content: {
                    ForEach(model.options, id: \.id) { option in
                        Text(option.title).tag(option.id)
                    }
                })
            .frame(width: 150)
            .pickerStyle(.segmented)
        }
        .onChange(of: model.selection) { index in
            model.selectionDidChange(model.options[index])
        }
    }
}

struct SegmentedCellView_Previews: PreviewProvider
{
    struct SegmentedCellView_Shim: View
    {
        var model: SegmentedCellModel<DurationPickerOption>
        
        var body: some View
        {
            SegmentedCellView(model: model)
        }
    }
    
    @State static var selectedOption: String?
    
    static var previews: some View
    {
        VStack
        {
            if let text = selectedOption { Text(text) }
            
            SegmentedCellView_Shim(model: .init(
                title: Strings.sectionDuration,
                options: DurationPickerOption.allCases,
                selection: 0,
                selectionDidChange: { selectedOption = $0.title }))
        }
    }
}
