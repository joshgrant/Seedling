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
    
    var body: some View
    {
        HStack
        {
            Checkbox(checked: $checked)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).strikethrough(checked).foregroundColor(checked ? .dust : .darkGrey) 
        }
    }
}

struct TaskCell_Previews: PreviewProvider
{
    static var previews: some View
    {
        TaskCell(checked: false)
    }
}
