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
    @Binding var buttonSize: CGFloat
    
    var outerCircleSize: CGFloat { buttonSize * 0.4 }
    var innerCircleSize: CGFloat { buttonSize * 0.3 }
    
    var body: some View
    {
        Button(
            action: toggleChecked,
            label: renderButton)
        .frame(
            width: buttonSize,
            height: buttonSize)
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
                .frame(
                    width: outerCircleSize,
                    height: outerCircleSize)
            Ellipse()
                .foregroundColor(Color.clementine)
                .opacity(checked ? 1 : 0)
                .frame(
                    width: innerCircleSize,
                    height: innerCircleSize)
        }
    }
}

struct Checkbox_Previews: PreviewProvider
{
    @State static var checked: Bool = true
    @State static var buttonSize: CGFloat = 44
    
    static var previews: some View
    {
        Checkbox(checked: $checked, buttonSize: $buttonSize)
    }
}
