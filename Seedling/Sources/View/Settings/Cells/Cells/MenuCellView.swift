// Copyright Team Seedling ©

import SwiftUI

struct MenuCellView<Option: PickerOption> : View
{
    @State var selection: Int = 0
    
    var title: String
    var options: [Option]
    
    var body: some View
    {
        SettingsCell(title: title)
        {
            Menu {
                Picker(
                    selection: $selection,
                    label: EmptyView(), // May be an issue in Mac
                    content: {
                        ForEach(options, id: \.id) { option in
                            Text(option.title).tag(option.id)
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
        Text(options[selection].title)
            .padding(3)
            .font(.system(
                size: 20,
                weight: .medium).monospaced())
            .frame(width: 100)
            .background(Material.bar)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .tint(.primary)
    }
}

struct MenuCellView_Previews: PreviewProvider
{
    enum TestOption: Int, PickerOption, CaseIterable
    {
        case solid
        case liquid
        case gas
        
        var id: Int { rawValue }
        var title: String
        {
            switch self
            {
            case .solid: return "solid"
            case .liquid: return "liquid"
            case .gas: return "gas"
            }
        }
    }
    
    static var previews: some View
    {
        MenuCellView(
            title: "Phase of matter",
            options: TestOption.allCases)
    }
}
