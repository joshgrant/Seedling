// Copyright Team Seedling ©

import SwiftUI

struct SectionHeader: View
{
    @ScaledMetric(relativeTo: .body) var textSize: CGFloat = 19
    @ScaledMetric(relativeTo: .body) var height: CGFloat = 44
    
    var title: String
    
    var body: some View
    {
        Text(title)
            .font(.system(size: textSize).monospaced())
            .fontWeight(.medium)
            .foregroundColor(SeedlingAsset.orange.swiftUIColor)
            .frame(minHeight: height)
            .frame(maxWidth: .infinity)
            .background(Material.bar)
    }
}

struct SectionHeader_Previews: PreviewProvider
{
    static var previews: some View
    {
        VStack
        {
            SectionHeader(title: "Priorities")
            SectionHeader(title: "Everything I Want To Do Today")
        }
    }
}
