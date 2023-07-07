// Copyright Team Seedling ©

import SwiftUI

struct DayPickerComponent: View
{
    @State private var date = Date()
    
    var body: some View
    {
        DatePicker(
            "Start Date",
            selection: $date,
            displayedComponents: [.date]
        )
        // TODO: Set the tint to match Seedling
        .datePickerStyle(.graphical)
        .onChange(of: date) { newValue in
            // TODO: Call a closure to update the day provider
            // TODO: Dismiss the sheet
        }
    }
    
}

struct DayPickerComponent_Previews: PreviewProvider {
    static var previews: some View {
        DayPickerComponent()
    }
}
