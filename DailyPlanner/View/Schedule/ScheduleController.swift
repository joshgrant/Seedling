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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ScheduleController: UITableViewDataSource {
    
    func hourForRow(at indexPath: IndexPath) -> Int? {
        let mapping: [Int: Int] = [
            0: 5,
            1: 6,
            2: 7,
            3: 8,
            4: 9,
            5: 10,
            6: 11,
            7: 12,
            8: 1,
            9: 2,
            10: 3,
            11: 4,
            12: 5,
            13: 6,
            14: 7,
            15: 8,
            16: 9,
            17: 10,
            18: 11
        ]
        return mapping[indexPath.row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 19
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let hour = hourForRow(at: indexPath) ?? -1
        cell.textLabel?.text = "\(hour)"
        return cell
    }
}

extension ScheduleController: UITableViewDelegate {
    
}
