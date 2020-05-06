//
//  ScheduleController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class ScheduleController: UIViewController {
    
    let tableView: UITableView
    
    required init?(coder: NSCoder = Coder()) {
        tableView = UITableView()
        
        super.init(coder: coder)
        
        tabBarItem = UITabBarItem(
            title: "Schedule",
            image: UIImage(named: "clock"),
            selectedImage: UIImage(named: "clockSelected"))
        
        view = tableView
    }
}
