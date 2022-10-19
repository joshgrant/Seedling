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
    @State var taskCellDefaultHeight: CGFloat = 44
    
    var textColor: Color
    {
        checked ? .dust : .darkGrey
    }
    
    var body: some View
    {
        HStack(spacing: 0)
        {
            Checkbox(
                checked: $checked,
                buttonSize: $taskCellDefaultHeight)
            VStack(spacing: 0)
            {
                TextField(Localizable.taskPlaceholder, text: $text, axis: .vertical)
                    .strikethrough(checked, color: textColor)
                    .foregroundColor(checked ? .dust : .darkGrey)
                    .padding(EdgeInsets(
                        top: 10,
                        leading: 0,
                        bottom: 10,
                        trailing: 10))
                    .font(.body.monospaced())
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.clementine)
            }
        }.accessibilityLabel("\(text): checked: \(checked.description)")
    }
}

struct TaskCell_Previews: PreviewProvider
{
    static var previews: some View
    {
        TaskCell(checked: false, text: "go to my sisters wedding and give her her present")
    }
}
