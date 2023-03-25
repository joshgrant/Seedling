// Copyright Team Seedling ©

import SwiftUI

struct SegmentedCellView: View
{
    @State var selection: Int = 0
    @ObservedObject var model: SegmentedCellModel
    
    var body: some View
    {
        SettingsCell(title: model.title)
        {
            Picker(
                selection: $selection,
                label: EmptyView(), // May be an issue in Mac
                content: {
                    ForEach(model.options, id: \.id) { option in
                        Text(option.title).tag(option.id)
                    }
                })
            .frame(width: 150)
            .pickerStyle(.segmented)
        }
        .onChange(of: selection) { index in
            model.selectionDidChange(model.options[index])
        }
    }
}

struct SegmentedCellView_Previews: PreviewProvider
{
    struct SegmentedCellView_Shim: View
    {
        var model: SegmentedCellModel
        
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
                options: PickerOption.durations,
                selectionDidChange: { selectedOption = $0.title }))
        }
    }
}
