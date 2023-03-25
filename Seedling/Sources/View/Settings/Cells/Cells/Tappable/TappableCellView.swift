// Copyright Team Seedling ©

import SwiftUI

struct TappableCellView<Content>: View where Content: View
{
    // MARK: - Variables
    
    @GestureState private var isTouchingDown = false
    @ObservedObject var model: TappableCellModel
    var label: Content
    
    // MARK: - Initialization
    
    init(model: TappableCellModel, @ViewBuilder label: () -> Content)
    {
        self.model = model
        self.label = label()
    }
    
    var body: some View
    {
        let tap = DragGesture(minimumDistance: 0)
            .updating($isTouchingDown, body: { _, isTouchingDown, _ in
                isTouchingDown = true
            })
        
        SettingsCell(title: model.title, label: {
            label
        })
        .background(isTouchingDown ? Color(white: 0.95) : SeedlingAsset.background.swiftUIColor)
        .onTapGesture(perform: model.action)
        .simultaneousGesture(tap)
    }
}

struct TappableCellView_Previews: PreviewProvider
{
    private struct TappableCell_Shim: View
    {
        @State static var showingText: Bool = false
        var model = TappableCellModel(
            title: "Hello",
            action: { Self.showingText.toggle() })
        
        var body: some View
        {
            VStack
            {
                if Self.showingText { Text("Showing text") }
                TappableCellView(model: model) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 21)
                }
            }
        }
    }
    
    static var previews: some View
    {
        TappableCell_Shim()
    }
}
