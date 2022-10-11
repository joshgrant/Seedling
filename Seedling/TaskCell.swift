//
//  TaskCell.swift
//  Seedling
//
//  Created by Jesse Vernon on 10/11/22.
//

import SwiftUI

struct TaskCell: View
{
    @State var checked: Bool
    @State var text: String
    
    var textColor: Color
    {
        checked ? .dust : .darkGrey
    }
    
    var body: some View
    {
        HStack
        {
            Checkbox(checked: $checked)
            VStack
            {
                TextField("Enter task", text: $text)
                    .strikethrough(checked, color: textColor)
                    .foregroundColor(checked ? .dust : .darkGrey)
                Rectangle().frame(height: 1).foregroundColor(.clementine)
            }
        }
    }
}

struct TaskCell_Previews: PreviewProvider
{
    static var previews: some View
    {
        TaskCell(checked: false, text: "Lol")
    }
}
