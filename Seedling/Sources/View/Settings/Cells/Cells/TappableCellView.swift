// Copyright Team Seedling ©

import SwiftUI

struct TappableCellView<Content>: View where Content: View
{
    @GestureState private var isTouchingDown = false
    
    var title: String
    var label: Content
    var action: () -> Void
    
    var body: some View {
        let tap = DragGesture(minimumDistance: 0)
            .updating($isTouchingDown, body: { _, isTouchingDown, _ in
                isTouchingDown = true
            })
        
        SettingsCell(title: title, label: {
            label
        })
        .background(isTouchingDown ? Color(white: 0.95) : SeedlingAsset.background.swiftUIColor)
        .onTapGesture(perform: action)
        .simultaneousGesture(tap)
    }
}

struct TappableCellView_Previews: PreviewProvider
{
    @State static var buttonPress: Bool = false
    
    static var previews: some View
    {
        VStack
        {
            if buttonPress
            {
                Text("Button was pressed!")
            }
            
            TappableCellView(
                title: "Hello",
                label: Image(systemName: "paperplane"),
                action: {
                     buttonPress = true
            })
        }
    }
}
