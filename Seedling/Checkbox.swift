//
//  Checkbox.swift
//  Seedling
//
//  Created by Jesse Vernon on 10/10/22.
//

import SwiftUI

struct Checkbox: View
{
    @State var checked: Bool
    
    var body: some View
    {
        ZStack
        {
            Ellipse()
                .stroke(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(Color("CheckboxBorder"))
                .frame(width: 18, height: 18)
            Ellipse()
                .foregroundColor(Color("Clementine"))
                .opacity(checked ? 1 : 0)
                .frame(width: 14, height: 14)
            Button(action: {
                checked.toggle()
            }, label: {})
        }
    }
}

struct Checkbox_Previews: PreviewProvider
{
    static var previews: some View
    {
        Checkbox(checked: false)
    }
}
