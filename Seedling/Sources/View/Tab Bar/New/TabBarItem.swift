// Copyright Team Seedling ©

import SwiftUI

struct TabBarItem: View
{
    @ScaledMetric(relativeTo: .body) var textSize: CGFloat = 12
    @Environment(\.verticalSizeClass) var sizeClass
    
    @ObservedObject var model: TabBarItemModel
    var action: (TabBarItemModel) -> Void
    
    var body: some View
    {
        CompactStack(spacing: 4) { horizontal, vertical in
            vertical != .compact
        } content: {
            Button(action: {
                action(model)
            }, label: image)
            
            if sizeClass == .regular
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
    
    @ViewBuilder private func image() -> some View
    {
        if model.selected
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

struct TabBarItem_Previews: PreviewProvider
{
    static var previews: some View
    {
        VStack
        {
            TabBarItem(
                model: .init(
                    id: 0,
                    unselectedImage: SeedlingAsset.toDoUnselected.swiftUIImage,
                    selectedImage: SeedlingAsset.toDoSelected.swiftUIImage,
                    title: SeedlingStrings.toDo.localizedCapitalized,
                    selected: true),
                action: { _ in })
            TabBarItem(
                model: .init(
                    id: 1,
                    unselectedImage: SeedlingAsset.toDoUnselected.swiftUIImage,
                    selectedImage: SeedlingAsset.toDoSelected.swiftUIImage,
                    title: SeedlingStrings.toDo.localizedCapitalized,
                    selected: false),
                action: { _ in })
        }
    }
}
