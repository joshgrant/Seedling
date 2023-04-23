// Copyright Team Seedling ©

import SwiftUI

public struct TabBarView<Content: View>: View
{
    @State var item: TabBarItemModel
    @State var itemVisible: Bool = true
    @ViewBuilder let content: () -> Content
    
    public var body: some View
    {
        content()
    }
}

struct TabBarView_Previews: PreviewProvider
{
    static var previews: some View
    {
        TabBarView(item: .toDo) {
            Text("Hi")
        }
    }
}
