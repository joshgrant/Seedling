// Copyright Team Seedling ©

import SwiftUI

struct PickerCellView: View
{
    @State var selection: Int = 0
    
    var body: some View
    {
        SettingsCell(title: "Section duration")
        {
            Picker("", selection: $selection)
            {
                Text("15m").tag(0)
                Text("30m").tag(1)
                Text("1hr").tag(2)
            }
            .frame(width: 150)
            .pickerStyle(.segmented)
        }
    }
}

struct PickerCellView_Previews: PreviewProvider {
    static var previews: some View {
        PickerCellView()
    }
}
