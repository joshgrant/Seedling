//
//  TabBar.swift
//  Seedling
//
//  Created by Joshua Grant on 10/13/22.
//

import SwiftUI

struct TabBar: View {
    
    private enum Tab: Hashable {
        case tasks
        case schedule
        case extras
        case settings
    }
    
    @State private var selectedTab: Tab = .tasks
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TestView()
                .tag(0)
                .tabItem {
                    Text("Tasks")
                    Image("tasks")
                }
            TestView()
                .tag(1)
                .tabItem {
                    Text("Schedule")
                    Image("schedule")
                }
            TestView()
                .tag(2)
                .tabItem {
                    Text("Extras")
                    Image("extras")
                }
            TestView()
                .tag(3)
                .tabItem {
                    Text("Settings")
                    Image("settings")
                }
        }
    }
}

struct TestView: View
{
    var body: some View {
        Button("Hello", action: { })
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
