//
//  CustomTableViewCell.swift
//  PluginTableView
//
//  Created by Dariel on 2019/8/7.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class CodeTableViewCell: UITableViewCell {
    var iconLabel: UILabel
    var iconView: UIImageView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        iconLabel = UILabel()
        iconView = UIImageView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(iconLabel)
        self.contentView.addSubview(iconView)
        
        setUpViews()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            iconView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            iconView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            iconView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor),
            
            iconLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            iconLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16)
            ])
    }
}
