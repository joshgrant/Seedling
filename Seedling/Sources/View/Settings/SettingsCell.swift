// Copyright Team Seedling ©

import SwiftUI

struct SettingsCell<Content>: View where Content: View
{
    // MARK: - Variables
    
    @ScaledMetric(relativeTo: .body) var titleSize: CGFloat = 19
    @ScaledMetric(relativeTo: .body) var subtitleSize: CGFloat = 16
    @ScaledMetric(relativeTo: .body) var titleSpacing: CGFloat = 4
    
    var title: String
    var subtitle: String?
    
    var label: Content
    
    // MARK: - Initialization
    
    init(
        title: String,
        subtitle: String? = nil,
        @ViewBuilder label: () -> Content)
    {
        self.title = title
        self.subtitle = subtitle
        self.label = label()
    }
    
    var body: some View
    {
        VStack(alignment: .leading, spacing: titleSpacing)
        {
            HStack(spacing: 0)
            {
                Text(title)
                    .font(.system(size: titleSize).monospaced())
                    .fontWeight(.medium)
                SwiftUI.Spacer()
                
                VStack(alignment: .leading)
                {
                    label
                }
                .frame(minWidth: 28)
            }
            
            if let subtitle = subtitle
            {
                Text(subtitle)
                    .font(.system(size: subtitleSize).monospaced())
                    .fontWeight(.light)
            }
        }
        .padding([.leading, .trailing], 20)
        .padding([.top, .bottom], 8)
        .frame(minHeight: 44)
    }
}

struct SettingsCell_Previews: PreviewProvider
{
    struct CheckboxPreviewView: View
    {
        @State var isOn: Bool = false
        
        var body: some View
        {
            SettingsCell(
                title: "Hide settings",
                subtitle: "To access settings, swipe right on the extras page",
                label: {
                    Toggle("", isOn: $isOn)
                        .toggleStyle(.circleCheck)
                })
        }
    }
    
    struct PickerPreviewView: View
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
    
    static var previews: some View
    {
        VStack
        {
            CheckboxPreviewView()
            PickerPreviewView()
        }
    }
}
