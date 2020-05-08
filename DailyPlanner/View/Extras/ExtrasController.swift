//
//  ExtrasController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class ExtrasController: UIViewController {
    
    let tableView: UITableView
    
    required init?(coder: NSCoder = Coder()) {
        tableView = UITableView()
        
        super.init(coder: coder)
        
        tabBarItem = UITabBarItem(
            title: "Extras",
            image: UIImage(named: "extras"),
            selectedImage: UIImage(named: "extrasSelected"))
        
        view = tableView
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ExtrasController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Test"
        return cell
    }
    
}

extension ExtrasController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Meals"
        case 1:
            return "Water"
        case 2:
            return "Pomodoro"
        case 3:
            return "Notes"
        default:
            return nil
        }
    }
}
