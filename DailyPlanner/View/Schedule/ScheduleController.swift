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
//    var dismissTapGesture: UITapGestureRecognizer!
    
    required init?(coder: NSCoder = Coder()) {
        tableView = UITableView()
        
        super.init(coder: coder)
        
//        dismissTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDismissTapGesture(_:)))
        
        tabBarItem = UITabBarItem(
            title: "Schedule",
            image: UIImage(named: "clock"),
            selectedImage: UIImage(named: "clockSelected"))
        
        view = tableView
        
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: "scheduleCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        tableView.keyboardDismissMode = .onDrag
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDismissTapGesture(_:)))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleDismissTapGesture(_ sender: UITapGestureRecognizer) {
        // Dismisses the active responder
        self.view.endEditing(false)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath)
        let hour = hourForRow(at: indexPath) ?? -1
        
        if let scheduleCell = cell as? ScheduleCell {
            scheduleCell.hourLabel.text = "\(hour)"
            
            if indexPath.row == 0 {
                scheduleCell.meridiemLabel.text = "AM"
            } else if indexPath.row == 7 {
                scheduleCell.meridiemLabel.text = "PM"
            }
            
            
            scheduleCell.configure(with: nil, delegate: self)
        }
        
//        cell.textLabel?.text = "\(hour)"
        return cell
    }
}

extension ScheduleController: UITableViewDelegate {
    
}

extension ScheduleController: CellTextViewDelegate {
	
	func textViewDidBeginEditing(_ textView: UITextView, in cell: UITableViewCell) {
		//
	}

    func textViewDidChange(_ textView: UITextView, in cell: UITableViewCell) {
        tableView.performBatchUpdates({
            UIView.animate(withDuration: 0.0) {
                cell.contentView.setNeedsLayout()
                cell.contentView.layoutIfNeeded()
            }
        }, completion: nil)
    }
	
	func textViewDidEndEditing(_ textView: UITextView, in cell: UITableViewCell) {
		textView.resignFirstResponder()
	}
	
	func textViewShouldReturn(_ textView: UITextView, in cell: UITableViewCell) -> Bool {
		return true
	}
}
