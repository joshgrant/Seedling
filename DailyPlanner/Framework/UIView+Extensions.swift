//
//  UIView+Extensions.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

extension UIView {
    
    func embed(view: UIView, padding: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: padding.top),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: padding.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: padding.bottom),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left)
        ])
    }
}
