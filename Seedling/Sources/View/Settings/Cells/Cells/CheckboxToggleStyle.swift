// Copyright Team Seedling ©

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle
{
    // MARK: - Variables
    
    @ScaledMetric(relativeTo: .body) var lineWidth: CGFloat = 1
    @ScaledMetric(relativeTo: .body) var padding: CGFloat = 3
    @ScaledMetric(relativeTo: .body) var size: CGFloat = 28
    
    func makeBody(configuration: Configuration) -> some View
    {
        Button(
            action: { configuration.isOn.toggle() },
            label: { concentricCircleStack(configuration: configuration) })
        .buttonStyle(.plain)
    }
    
    func concentricCircleStack(configuration: Configuration) -> some View
    {
        ZStack
        {
            Circle()
                .strokeBorder(
                    SeedlingAsset.separator.swiftUIColor,
                    lineWidth: lineWidth)
            Circle()
                .fill(.tint)
                .tint(configuration.isOn
                      ? SeedlingAsset.orange.swiftUIColor
                      : .clear)
                .padding(padding)
        }
        .frame(width: size, height: size)
    }
}

extension ToggleStyle where Self == CheckboxToggleStyle
{
    static var circleCheck: CheckboxToggleStyle
    {
        .init()
    }
}

struct CheckboxToggleStyle_Previews: PreviewProvider
{
    struct PreviewView: View
    {
        @State var isOn: Bool
        
        var body: some View
        {
            Toggle("Switch me", isOn: $isOn)
                .toggleStyle(CheckboxToggleStyle())
        }
    }
    
    static var previews: some View
    {
        Group
        {
            PreviewView(isOn: true)
            PreviewView(isOn: false)
        }
    }
}
