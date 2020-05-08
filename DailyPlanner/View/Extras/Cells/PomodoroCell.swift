//
//  PomodoroCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class PomodoroCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let leftPadding = UIView()
        let rightPadding = UIView()
        
        let vStack = UIStackView(arrangedSubviews: [
            makeStackView(),
            makeStackView()
        ])
        vStack.spacing = 12
        vStack.axis = .vertical
        
        let hStack = UIStackView(arrangedSubviews: [
            leftPadding,
            vStack,
            rightPadding
        ])
        
        leftPadding.widthAnchor.constraint(equalTo: rightPadding.widthAnchor).isActive = true
        
        contentView.embed(view: hStack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "clearBubble"), for: .normal)
        button.addTarget(self, action: #selector(didTouchUpInsideBubble(sender:)), for: .touchUpInside)
        return button
    }
    
    @objc func didTouchUpInsideBubble(sender: UIButton) {
        sender.setImage(UIImage(named: "orangeBubble"), for: .normal)
    }
    
    func makeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            makeButton(),
            makeButton(),
            makeButton(),
            makeButton(),
            makeButton(),
            makeButton(),
            makeButton(),
            makeButton()
        ])
        stackView.spacing = 10
        return stackView
    }
}
