//
//  TaskSection.swift
//  Seedling
//
//  Created by Jesse Vernon on 10/13/22.
//

import SwiftUI

struct TaskTemp
{
    var checked: Bool
    var content: String
    var id = UUID()
}

extension TaskTemp: Identifiable
{
    typealias ID = UUID
}

struct TaskSection: View
{
    @State var tasks: [TaskTemp]
    
    var body: some View
    {
        List(tasks, id: \.id) { task in
            TaskCell(checked: task.checked, text: task.content)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
    }
}

struct TaskSection_Previews: PreviewProvider {
    static var previews: some View {
        TaskSection(tasks: [
            .init(checked: false, content: "clean the kitchen"),
            .init(checked: true, content: "go to walmart"),
            .init(checked: false, content: "pick up daniel"),
            .init(checked: true, content: "go to my sisters wedding and give her her present")
        ])
    }
}
