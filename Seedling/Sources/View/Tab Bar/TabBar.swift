// Copyright Team Seedling ©

import SwiftUI


// TODO: Items are not sized evenly
// TODO: Test on smaller iPhones and iPads
// TODO: Add a top border to the view
// TODO: Break into separate files
// TODO: Geometry reader is annoying - how to allow view to be centered?
// TODO: Rotation animation is not beautiful
// TODO: Tab bar items don't switch tabs
// TODO: Check dark mode support
// TODO: Allow swiping between tabs

class TabBarItemModel: ObservableObject
{
    var id: Int
    var unselectedImage: Image
    var selectedImage: Image
    var title: String
    
    @State var selected: Bool = false
    
    init(
        id: Int,
        unselectedImage: Image,
        selectedImage: Image,
        title: String)
    {
        self.id = id
        self.unselectedImage = unselectedImage
        self.selectedImage = selectedImage
        self.title = title
    }
}

extension TabBarItemModel: Equatable
{
    static func == (lhs: TabBarItemModel, rhs: TabBarItemModel) -> Bool
    {
        lhs.id == rhs.id
    }
}

class TabBarModel: ObservableObject
{
    var items: [TabBarItemModel]
    var selectedItem: TabBarItemModel? {
        didSet {
            items.forEach { $0.selected = false }
            selectedItem?.selected = true
        }
    }
    
    init(items: [TabBarItemModel])
    {
        self.items = items
        
        if let first = items.first
        {
            self.selectedItem = first
        }
    }
}

extension TabBarModel
{
    static let `default` = TabBarModel(items:  [
        .init(
            id: 0,
            unselectedImage: SeedlingAsset.toDoUnselected.swiftUIImage,
            selectedImage: SeedlingAsset.toDoSelected.swiftUIImage,
            title: SeedlingStrings.toDo.localizedCapitalized),
        .init(
            id: 1,
            unselectedImage: SeedlingAsset.scheduleUnselected.swiftUIImage,
            selectedImage: SeedlingAsset.scheduleSelected.swiftUIImage,
            title: SeedlingStrings.schedule.localizedCapitalized),
        .init(
            id: 2,
            unselectedImage: SeedlingAsset.extrasUnselected.swiftUIImage,
            selectedImage: SeedlingAsset.extrasSelected.swiftUIImage,
            title: SeedlingStrings.extras.localizedCapitalized),
        .init(
            id: 3,
            unselectedImage: SeedlingAsset.settingsUnselected.swiftUIImage,
            selectedImage: SeedlingAsset.settingsSelected.swiftUIImage,
            title: SeedlingStrings.settings.localizedCapitalized)
    ])
}

struct VHStack<Content: View>: View
{
    @Environment(\.horizontalSizeClass) var sizeClass
    let content: Content
    
    init(@ViewBuilder content: () -> Content)
    {
        self.content = content()
    }
    
    var body: some View
    {
        if sizeClass == .regular
        {
            VStack
            {
                content
            }
        }
        else
        {
            HStack
            {
                content
            }
        }
    }
}

struct HVStack<Content: View>: View
{
    @Environment(\.horizontalSizeClass) var sizeClass
    let content: Content
    
    init(@ViewBuilder content: () -> Content)
    {
        self.content = content()
    }
    
    var body: some View
    {
        if sizeClass == .compact
        {
            VStack
            {
                content
            }
        }
        else
        {
            HStack
            {
                content
            }
        }
    }
}

struct TabBarItem: View
{
    @ScaledMetric(relativeTo: .body) var textSize: CGFloat = 14
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var model: TabBarItemModel
    var selected: Bool
    
    var body: some View
    {
        HVStack
        {
            Button {
                print("Tapped on me!!!")
            } label: {
                image
            }
            
            if sizeClass == .compact
            {
                title
            }
        }
    }
    
    @ViewBuilder private var title: some View
    {
        Text(model.title)
            .foregroundColor(.white)
            .font(.system(size: textSize, weight: .semibold, design: .monospaced))
    }
    
    @ViewBuilder private var image: some View
    {
        if selected
        {
            model.selectedImage
                .foregroundColor(.white)
        }
        else
        {
            model.unselectedImage
                .foregroundColor(.white)
        }
    }
}

struct TabBar<Content: View>: View
{
    @Environment(\.horizontalSizeClass) var hSizeClass
    @Environment(\.verticalSizeClass) var vSizeClass
    
    var model: TabBarModel
    let content: Content
    
    init(model: TabBarModel, @ViewBuilder content: () -> Content) {
        self.model = model
        self.content = content()
    }
    
    var body: some View
    {
        GeometryReader { context in
            content
        }
        .if(hSizeClass == .compact) { view in
            view.safeAreaInset(edge: .bottom) {
                tabItems
                .frame(height: 49)
            }
            .animation(.linear(duration: 0), value: hSizeClass)
        }
        .if(hSizeClass == .regular) { view in
            view.safeAreaInset(edge: .leading) {
                tabItems
                    .frame(width: 49)
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
            
            VHStack
            {
                SwiftUI.Spacer()
                ForEach(model.items, id: \.id) { itemModel in
                    TabBarItem(model: itemModel, selected: model.selectedItem == itemModel)
                    SwiftUI.Spacer()
                }
            }
            .padding(4)
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

struct SlidingTabBar_Previews: PreviewProvider
{
    static var previews: some View
    {
        return TabBar(model: .default) {
            Text("Hi")
        }
    }
}
