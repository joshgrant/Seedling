//
//  TabBar.swift
//  Seedling
//
//  Created by Joshua Grant on 10/13/22.
//

import SwiftUI

struct TabBar: View {
    
    // TODO: Why doesn't this work with @State to update the DOM?
    private enum Tab: Int, Hashable {
        case tasks
        case schedule
        case extras
        case settings
        
        func image(selectedTab: Tab) -> String {
            switch self {
            case .tasks:
                return selectedTab == self ? "tasks_selected" : "tasks_unselected"
            case .schedule:
                return selectedTab == self ? "schedule_selected" : "schedule_unselected"
            case .extras:
                return selectedTab == self ? "extras_selected" : "extras_unselected"
            case .settings:
                return selectedTab == self ? "settings_selected" : "settings_unselected"
            }
        }
    }
    
    @State private var selectedTab: Int = Tab.tasks.rawValue
    
    init()
    {
        UITabBar.appearance().backgroundColor = .emerald
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().unselectedItemTintColor = .white
    }
    
    // TODO: clean tbis up 
    var body: some View {
        TabView(selection: $selectedTab) {
            TaskSection(tasks: [.init(checked: true, content: "hi")])
                .tag(Tab.tasks.rawValue)
                .tabItem {
                    Label("Tasks", image: selectedTab == Tab.tasks.rawValue
                        ? "tasks_selected"
                        : "tasks_unselected")
                }
                .accentColor(.green)
            TestView()
                .tag(Tab.schedule.rawValue)
                .tabItem {
                    Label("Schedule", image: selectedTab == Tab.schedule.rawValue
                        ? "schedule_selected"
                        : "schedule_unselected")
                }
                .accentColor(.green)
            TestView()
                .tag(Tab.extras.rawValue)
                .tabItem {
                    Label("Extras", image: selectedTab == Tab.extras.rawValue
                        ? "extras_selected"
                      : "extras_unselected")
                }
                .accentColor(.green)
            TestView()
                .tag(Tab.settings.rawValue)
                .tabItem {
                    Label("Settings", image: selectedTab == Tab.settings.rawValue
                        ? "settings_selected"
                        : "settings_unselected")
                }
                .accentColor(.green)
        }.accentColor(.white)
    }
}

struct TestView: View
{
    var body: some View {
        List(0..<18) { row in
            Button("\(row)", action: {})
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
