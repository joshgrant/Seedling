// Copyright Team Seedling ©

import SwiftUI

struct CheckboxCellView: View
{
    @ObservedObject var model: CheckboxCellModel
    
    var body: some View
    {
        SettingsCell(
            title: model.title,
            subtitle: model.subtitle)
        {
            toggle
        }
        .onChange(of: model.isOn, perform: model.action)
    }
    
    var toggle: some View
    {
        Toggle("", isOn: $model.isOn)
            .toggleStyle(CheckboxToggleStyle())
    }
}

struct CheckboxCellView_Previews: PreviewProvider
{
    struct CheckboxCellView_Shim: View
    {
        @ObservedObject var model: CheckboxCellModel
        
        var body: some View
        {
            CheckboxCellView(model: model)
        }
    }
    
    @State static var textShowing: Bool = false
    
    static var previews: some View
    {
        VStack
        {
            if textShowing { Text("Text showing") }
            
            CheckboxCellView_Shim(model: .init(
                isOn: true,
                title: Strings.hideSettings,
                subtitle: Strings.toAccessSettings,
                action: { _ in Self.textShowing.toggle() }))
            CheckboxCellView_Shim(model: .init(
                isOn: false,
                title: Strings.monospacedFont,
                action: { _ in Self.textShowing.toggle() }))
        }
    }
}
