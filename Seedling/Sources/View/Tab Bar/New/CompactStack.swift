// Copyright Team Seedling ©

import SwiftUI

struct Alignment
{
    var vAlignment: VerticalAlignment
    var hAlignment: HorizontalAlignment
    
    static let `default` = Alignment(
        vAlignment: .center,
        hAlignment: .center)
}

struct CompactStack<Content: View>: View
{
    typealias SizeClass = UserInterfaceSizeClass
    typealias Condition = (_ horizontal: SizeClass?, _ vertical: SizeClass?) -> Bool
    
    @Environment(\.verticalSizeClass) var vSizeClass
    @Environment(\.horizontalSizeClass) var hSizeClass
    
    let alignment: Alignment
    let spacing: CGFloat
    let condition: Condition
    @ViewBuilder let content: () -> Content
    
    init(alignment: Alignment = .default, spacing: CGFloat = 8, condition: @escaping Condition, @ViewBuilder content: @escaping () -> Content)
    {
        self.alignment = alignment
        self.spacing = spacing
        self.condition = condition
        self.content = content
    }
    
    var body: some View
    {
        if condition(hSizeClass, vSizeClass)
        {
            VStack(
                alignment: alignment.hAlignment,
                spacing: spacing,
                content: content)
        }
        else
        {
            HStack(
                alignment: alignment.vAlignment,
                spacing: spacing,
                content: content)
        }
    }
}

struct CompactStack_Previews: PreviewProvider {
    static var previews: some View {
        Group
        {
            CompactStack { horizontal, vertical in
                horizontal == .regular
            } content: {
                Text("Left")
                Text("Right")
            }
            .environment(\.horizontalSizeClass, .regular)
            
            CompactStack { horizontal, vertical in
                horizontal == .regular
            } content: {
                Text("Top")
                Text("Bottom")
            }
            .environment(\.horizontalSizeClass, .compact)
        }
    }
}
