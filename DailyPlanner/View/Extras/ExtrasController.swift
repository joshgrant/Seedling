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
        tableView.separatorStyle = .none
        
        super.init(coder: coder)
        
        tabBarItem = UITabBarItem(
            title: "Extras",
            image: UIImage(named: "extras"),
            selectedImage: UIImage(named: "extrasSelected"))
        
        view = tableView
        
        tableView.register(MealsCell.self, forCellReuseIdentifier: "mealsCell")
        tableView.register(WaterCell.self, forCellReuseIdentifier: "waterCell")
        tableView.register(PomodoroCell.self, forCellReuseIdentifier: "pomodoroCell")
        tableView.register(NotesCell.self, forCellReuseIdentifier: "notesCell")
        
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
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mealsCell", for: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "waterCell", for: indexPath)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "pomodoroCell", for: indexPath)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath)
            return cell
        default:
            break
        }
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "Test"
//        return cell
    }
    
}

extension ExtrasController: UITableViewDelegate {
    
    // TODO: Copied from TodoController
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.font = UIFont.monospacedSystemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor(named: "orange")
        label.textAlignment = .center
        
        switch section {
        case 0:
            label.text = "Meals"
        case 1:
            label.text = "Water"
        case 2:
            label.text = "Pomodoro"
        case 3:
            label.text = "Notes"
        default:
            break
        }
        
        let vStack = UIStackView(arrangedSubviews: [UIView(), label])
        vStack.axis = .vertical
        
        return vStack
    }
}
