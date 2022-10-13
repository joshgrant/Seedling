//
//  TaskSection.swift
//  Seedling
//
//  Created by Jesse Vernon on 10/13/22.
//

import SwiftUI

struct TaskSection: View {
    var body: some View {
        LazyVStack(spacing: 0, pinnedViews: .sectionHeaders)
        {
            TaskCell(checked: false, text: "wow this is so awesome oh my gosh wowie")
            TaskCell(checked: false, text: "wow")
            TaskCell(checked: false, text: "wow")
            TaskCell(checked: false, text: "wow")
            TaskCell(checked: false, text: "wow")
            TaskCell(checked: false, text: "wow ooga booga unga bunga i am a cave man")
            TaskCell(checked: false, text: "wow")
            TaskCell(checked: false, text: "wow")
            
        }
    }
}

struct TaskSection_Previews: PreviewProvider {
    static var previews: some View {
        TaskSection()
    }
}
