// Copyright Team Seedling ©

import SwiftUI

struct CheckboxCellView: View
{
    @State var isOn: Bool
    
    var title: String
    var subtitle: String?
    
    var body: some View
    {
        SettingsCell(title: title, subtitle: subtitle) {
            Toggle("", isOn: $isOn)
                .toggleStyle(CheckboxToggleStyle())
        }
    }
}

struct CheckboxCellView_Previews: PreviewProvider
{
    static var previews: some View
    {
        VStack
        {
            CheckboxCellView(
                isOn: true,
                title: "Hide settings",
                subtitle: "To access settings, swipe right on the extras page")
            
            CheckboxCellView(
                isOn: false,
                title: "Monospaced font"
            )
            CheckboxCellView(
                isOn: false,
                title: "Lowercase text"
            )
        }
    }
}
