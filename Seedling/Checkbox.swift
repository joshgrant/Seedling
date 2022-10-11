//
//  Checkbox.swift
//  Seedling
//
//  Created by Jesse Vernon on 10/10/22.
//

import SwiftUI

struct Checkbox: View
{
    @Binding var checked: Bool
    
    var body: some View
    {
        Button(
            action: toggleChecked,
            label: renderButton)
        .frame(width: 44, height: 44)
    }
    
    func toggleChecked()
    {
        checked.toggle()
    }
    
    func renderButton() -> some View
    {
        ZStack
        {
            Ellipse()
                .stroke(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(Color.darkGrey)
                .frame(width: 18, height: 18)
            Ellipse()
                .foregroundColor(Color.clementine)
                .opacity(checked ? 1 : 0)
                .frame(width: 14, height: 14)
        }
    }
}

struct Checkbox_Previews: PreviewProvider
{
    @State static var checked: Bool = true
    
    static var previews: some View
    {
        Checkbox(checked: $checked)
    }
}
