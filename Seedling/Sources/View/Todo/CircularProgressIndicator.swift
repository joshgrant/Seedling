// Copyright Team Seedling ©

import SwiftUI

struct CircularProgressIndicator: View
{
    @ScaledMetric(relativeTo: .body) var textSize: CGFloat = 18
    @ScaledMetric(relativeTo: .body) var radiusSize: CGFloat = 12.5
    @ScaledMetric(relativeTo: .body) var frameSize: CGFloat = 31
    @ScaledMetric(relativeTo: .body) var lineWidth: CGFloat = 1
    @State var endAngle: Double = -90.0
    @State var uncompletedCount: Int
    
    var body: some View
    {
        VStack
        {
            Slider(value: $endAngle, in: -90...270)
            Text(SeedlingStrings.moveUncompleted(uncompletedCount))
                .font(.system(size: textSize).monospaced())
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 40)
            ZStack
            {
                Circle().strokeBorder(SeedlingAsset.darkGrey.swiftUIColor, lineWidth: lineWidth)
                GeometryReader { proxy in
                    Path { path in
                        let center = CGPoint(x: proxy.size.width*0.5, y: proxy.size.height*0.5)
                        path.move(to: center)
                        path.addArc(
                            center: center,
                            radius: radiusSize,
                            startAngle: .degrees(-90.0),
                            endAngle: .degrees(endAngle),
                            clockwise: false,
                            transform: .identity)
                    }.fill(SeedlingAsset.orange.swiftUIColor)
                }
            }.frame(width: frameSize, height: frameSize)
        }
    }
}

struct CircularProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressIndicator( uncompletedCount: 6)
    }
}
