// Copyright Team Seedling ©

import SwiftUI

struct MenuCellView<Option: PickerOption>: View
{
    // MARK: - Variables
    
    @ScaledMetric(relativeTo: .body) var fontSize: CGFloat = 20
    @ScaledMetric(relativeTo: .body) var width: CGFloat = 100
    @ObservedObject var model: MenuCellModel<Option>
    
    // MARK: - View
    
    var body: some View
    {
        SettingsCell(title: model.title)
        {
            Menu {
                Picker(
                    selection: $model.selection,
                    label: EmptyView(), // May be an issue in Mac
                    content: {
                        ForEach(model.options, id: \.id) { option in
                            Text(option.title).tag(option.sortIndex)
                        }
                    })
                .pickerStyle(.automatic)
            } label: {
                pickerLabel
            }
        }
    }
    
    var pickerLabel: some View
    {
        Text(model.options[model.selection].title)
            .padding(3)
            .font(.system(
                size: fontSize,
                weight: .medium).monospaced())
            .frame(width: width)
            .background(Material.bar)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .tint(.primary)
    }
}

struct MenuCellView_Previews: PreviewProvider
{
    struct MenuCellView_Shim: View
    {
        var model: MenuCellModel<WaterPickerOption>
        
        var body: some View
        {
            MenuCellView(model: model)
        }
    }
    
    @State static var selection: String? = nil
    
    static var previews: some View
    {
        VStack
        {
            if let selection = selection { Text(selection) }
            MenuCellView_Shim(model: .init(
                title: Strings.waterAmount,
                options: WaterPickerOption.allCases,
                selection: 0,
                selectionDidChange: { selection = $0.title }))
        }
    }
}
