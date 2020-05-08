//
//  TaskCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class TaskCellModel {
    
}

class TaskCell: UITableViewCell {
    
    let checkBox: UIButton
    let textField: TextField
//    let stackView: UIStackView
    
    var task: Task?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        checkBox = UIButton()
        checkBox.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        textField = TextField()
        textField.font = UIFont.monospacedSystemFont(ofSize: 17, weight: .regular)
        textField.textColor = UIColor(named: "text")
        
        let hStack = UIStackView(arrangedSubviews: [checkBox, textField])
        
        let lineSeparator = UIView()
        lineSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineSeparator.backgroundColor = UIColor(named: "orange")
        
        let spacer = UIView()
        spacer.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        let hStack2 = UIStackView(arrangedSubviews: [spacer, lineSeparator])
        
        let vStack = UIStackView(arrangedSubviews: [hStack, hStack2])
        vStack.axis = .vertical
        
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        checkBox.addTarget(self, action: #selector(didTouchUpInsideCheckBox(_:)), for: .touchUpInside)
        textField.delegate = self
        
        contentView.embed(view: vStack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with task: Task) {
        self.task = task
        
        textField.text = task.content
        
        if task.completed {
            checkBox.setImage(UIImage(named: "taskComplete"), for: .normal)
        } else {
            checkBox.setImage(UIImage(named: "taskIncomplete"), for: .normal)
        }
    }
    
    @objc func didTouchUpInsideCheckBox(_ sender: UIButton) {
        Database.context.perform {
            self.task?.completed.toggle()
            if let task = self.task {
                self.configure(with: task)
            }
            Database.save() // Is it possible to create a retain loop here?
        }
    }
    
    func textHeight() -> CGSize {
        
        return .zero
//        textField.size
//        let size = textField.sizeThatFits(CGSize(width: textField.frame.size.width, height: .greatestFiniteMagnitude))
//        return size
        
//        #define MAX_HEIGHT 2000
//
//        NSString *foo = @"Lorem ipsum dolor sit amet.";
//        CGSize size = [foo sizeWithFont:[UIFont systemFontOfSize:14]
//                      constrainedToSize:CGSizeMake(100, MAX_HEIGHT)
//                          lineBreakMode:UILineBreakModeWordWrap];
//
//        and then you can use this with your UITextView:
//
//        [textView setFont:[UIFont systemFontOfSize:14]];
//        [textView setFrame:CGRectMake(5, 30, 100, size.height + 10)];
    }
}

extension TaskCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Database.context.perform {
            self.task?.content = textField.text
            Database.save()
        }
    }
}

