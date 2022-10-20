//
//  MainView.swift
//  Seedling
//
//  Created by Jesse Vernon on 10/20/22.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact {
            TabBar()
        } else {
            TaskSection(tasks: [.init(checked: true, content: "Sup")])
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
