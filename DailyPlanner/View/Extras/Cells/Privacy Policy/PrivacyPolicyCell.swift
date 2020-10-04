//
//  PrivacyPolicyCell.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 10/4/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class PrivacyPolicyCell: UITableViewCell
{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.addTarget(self, action: #selector(privacyPolicyButtonDidTouchUpInside(_:)), for: .touchUpInside)
        button.setTitleColor(.type(.emerald), for: .normal)
        
        let stackView = UIStackView(arrangedSubviews: [button])
        contentView.embed(view: stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Button action
    
    @objc func privacyPolicyButtonDidTouchUpInside(_ sender: UIButton)
    {
        guard let url = URL(string: "https://bloomingthyme.com/?page_id=168") else {
            print("URL invalid")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
