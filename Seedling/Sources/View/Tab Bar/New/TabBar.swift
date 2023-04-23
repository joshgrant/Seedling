// Copyright Team Seedling ©

import SwiftUI


// TODO: Geometry reader is annoying - how to allow view to be centered?
// TODO: Rotation animation is not beautiful
// TODO: Tab bar items don't switch tabs
// TODO: Check dark mode support
// TODO: Allow swiping between tabs

struct TabBar: View
{
    @Environment(\.horizontalSizeClass) var hSizeClass
    @Environment(\.verticalSizeClass) var vSizeClass
    
    @ObservedObject var model: TabBarModel
    
    init(model: TabBarModel)
    {
        self.model = model
    }
    
    var body: some View
    {
        GeometryReader { context in
            model.selectedTab
        }
        .if(vSizeClass == .compact) { view in
            view.safeAreaInset(edge: .leading) {
                tabItems
                    .frame(width: 49)
            }
            .animation(.linear(duration: 0), value: hSizeClass)
        }
        .if(vSizeClass != .compact) { view in
            view.safeAreaInset(edge: .bottom) {
                tabItems
                .frame(height: 49)
            }
            .animation(.linear(duration: 0), value: hSizeClass)
        }
    }

    
    @ViewBuilder private var tabItems: some View
    {
        ZStack
        {
            SeedlingAsset
                .emerald
                .swiftUIColor
                .ignoresSafeArea(.container, edges: edgesForHorizontalSizeClass)
            VStack
            {
                CompactStack { horizontal, vertical in
                    vertical == .compact
                } content: {
                    ForEach(model.tabs, id: \.item.id) { tab in
                        TabBarItem(
                            model: tab.item,
                            action: { _ in
                                model.selectedItem = tab.item
                            })
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .padding(4)
            }
        }
    }
    
    var edgesForHorizontalSizeClass: Edge.Set
    {
        if hSizeClass == .compact
        {
            return [.leading, .bottom, .trailing]
        }
        else
        {
            return [.top, .leading, .bottom]
        }
    }
}

struct TabBar_Previews: PreviewProvider
{
    static var previews: some View
    {
        Text("Hi")
    }
}
