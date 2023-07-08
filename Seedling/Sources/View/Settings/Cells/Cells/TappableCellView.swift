// Copyright Team Seedling ©

import SwiftUI

struct TappableCellView<Content, Destination>: View where Content: View, Destination: View
{
    var title: String
    var label: Content
    @ViewBuilder var destination: () -> Destination
    
    var body: some View
    {
        NavigationLink {
            destination()
                .tint(SeedlingAsset.emerald.swiftUIColor)
        } label: {
            SettingsCell(title: title, label: {
                label
            })
            .tint(SeedlingAsset.emerald.swiftUIColor)
        }
    }
}

struct TappableCellView_Previews: PreviewProvider
{
    static var previews: some View
    {
        NavigationStack {
            VStack
            {
                TappableCellView(
                    title: "Hello",
                    label: Image(systemName: "paperplane"),
                    destination: {
                        Text("Hi!")
                    })
            }
        }
        .tint(SeedlingAsset.emerald.swiftUIColor)
    }
}
