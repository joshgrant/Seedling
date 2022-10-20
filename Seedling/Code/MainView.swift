//
//  MainView.swift
//  Seedling
//
//  Created by Jesse Vernon on 10/20/22.
//

import SwiftUI

struct MainView: View
{
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View
    {
        if horizontalSizeClass == .compact
        {
            TabBar()
        }
        else
        {
            ScrollView(.horizontal)
            {
                HStack
                {
                    TaskSection(tasks: [.init(checked: true, content: "1")])
                    TaskSection(tasks: [.init(checked: true, content: "2")])
                    TaskSection(tasks: [.init(checked: true, content: "3")])
                    TaskSection(tasks: [.init(checked: true, content: "4")])
                }.frame(width: 1800) // TODO: Maybe make this dynamic (like each section has a minimum width and the HStack has a maximum width)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider
{
    static var previews: some View
    {
        MainView()
    }
}
