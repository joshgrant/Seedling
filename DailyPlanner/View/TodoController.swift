//
//  TodoController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

protocol DayProvider: class {
    var day: Day { get set }
}

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
                
        //        navigationItem = UINavigationItem(title: "Today")
                
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
                
                view = tableView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TodoController: UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "TODO"
        return cell
    }
}

extension TodoController: UITableViewDelegate {
    
}
