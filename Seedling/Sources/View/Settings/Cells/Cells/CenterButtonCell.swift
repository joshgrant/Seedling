// Copyright Team Seedling ©

import SwiftUI

struct CenterButtonCell: View
{
    @ScaledMetric(relativeTo: .body) var fontSize: CGFloat = 18
    
    var title: String
    var image: SwiftUI.Image?
    var action: () -> Void
    
    var body: some View
    {
        Button(action: action)
        {
            HStack
            {
                if let image = image
                {
                    image
                }
                
                Text(title)
                    .font(.system(size: fontSize, weight: .medium).monospaced())
            }
        }
        .tint(SeedlingAsset.orange.swiftUIColor)
        .buttonStyle(.borderedProminent)
        .padding(20)
    }
}

struct CenterButtonCell_Previews: PreviewProvider
{
    static var previews: some View
    {
        CenterButtonCell(
            title: "Hello, world",
            image: Image(systemName: "paperplane"),
            action: {})
    }
}
