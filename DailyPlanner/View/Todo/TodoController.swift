//
//  TodoController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TodoController: UIViewController {
    
    let tableView: UITableView
    
    weak var dayProvider: DayProvider?
    
    init?(dayProvider: DayProvider) {
        self.dayProvider = dayProvider
        
        tableView = UITableView(frame: .zero, style: .grouped)
        super.init(coder: Coder())
        tabBarItem = UITabBarItem(
            title: "To do",
            image: UIImage(named: "todo"),
            selectedImage: UIImage(named: "todoSelected"))
        //        tabBarItem.landscapeImagePhone = UIImage(named: "todoCompact")
        // Good for accessibility
        //        tabBarItem.largeContentSizeImage
        
        tableView.backgroundColor = .white
        
        tableView.register(TaskCell.self, forCellReuseIdentifier: "taskCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        view = tableView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TodoController: UITableViewDataSource {
    
    func task(at indexPath: IndexPath) -> Task? {
        switch indexPath.row {
        case 0:
            return dayProvider?.day.prioritiesArray[indexPath.row]
        case 1:
            return dayProvider?.day.todosArray[indexPath.row]
        default:
            return nil
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dayProvider?.day.priorities?.count ?? 0
        case 1:
            return dayProvider?.day.todos?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        configure(taskCell: cell, at: indexPath)
        return cell
    }
    
    func configure(taskCell: UITableViewCell, at indexPath: IndexPath) {
        if let cell = taskCell as? TaskCell, let task = task(at: indexPath) {
            cell.configure(with: task)
        }
    }
}

extension TodoController: UITableViewDelegate {
    
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
            label.text = "Priorities"
        case 1:
            label.text = "Todos"
        default:
            break
        }
        
        let vStack = UIStackView(arrangedSubviews: [UIView(), label])
        vStack.axis = .vertical
        
        return vStack
    }
}
