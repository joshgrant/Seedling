// Copyright Team Seedling ©

import SwiftUI

struct CenterButtonCellView: View
{
    // MARK: - Variables
    
    @ScaledMetric(relativeTo: .body) var fontSize: CGFloat = 18
    @ObservedObject var model: CenterButtonCellModel
    
    // MARK: - Initialization
    
    var body: some View
    {
        Button(action: model.action)
        {
            HStack
            {
                if let image = model.image
                {
                    image
                }
                
                Text(model.title)
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
    struct CenterButtonCell_Shim: View
    {
        var model: CenterButtonCellModel
        
        var body: some View
        {
            CenterButtonCellView(model: model)
        }
    }
    
    static var previews: some View
    {
        Group
        {
            CenterButtonCell_Shim(model: .init(
                title: "Hello, world!",
                image: Image(systemName: "paperplane"),
                action: {}))
        }
    }
}
