//
//  WaterCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class WaterCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let leftPadding = UIView()
        let rightPadding = UIView()
        
        let vStack = UIStackView(arrangedSubviews: [
            makeStackView(),
            makeStackView()
        ])
        vStack.axis = .vertical
        vStack.spacing = 15
        
        let hStack = UIStackView(arrangedSubviews: [
            leftPadding,
            vStack,
            rightPadding
        ])
        
        // Add these after added to parent view
        rightPadding.widthAnchor.constraint(equalTo: leftPadding.widthAnchor).isActive = true
        
        contentView.embed(view: hStack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            makeButton(),
            makeButton(),
            makeButton(),
            makeButton(),
            makeButton(),
            makeButton(),
        ])
        stackView.spacing = 15
        return stackView
    }
    
    func makeButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "clearBubble"), for: .normal)
        button.addTarget(self, action: #selector(didTouchUpInsideBubble(_:)), for: .touchUpInside)
        // Why is the selector crossed out?
        return button
    }
    
    @objc func didTouchUpInsideBubble(_ sender: UIButton) {
        sender.setImage(UIImage(named: "blueBubble"), for: .normal)
    }
}
