// Copyright Team Seedling ©

import SwiftUI

struct CircularProgressIndicator: View {
    @State var endAngle: Double = -90.0
    var body: some View {
        VStack{
            Slider(value: $endAngle, in: -90...270)
            GeometryReader { proxy in
                Path { path in
                    let center = CGPoint(x: proxy.size.width*0.5, y: proxy.size.height*0.5)
                    path.move(to: center)
                    path.addArc(
                        center: center,
                        radius: 40,
                        startAngle: .degrees(-90.0),
                        endAngle: .degrees(endAngle),
                        clockwise: false,
                        transform: .identity)
                }.fill(.orange)
            }
        }
    }
}

struct CircularProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressIndicator()
    }
}
