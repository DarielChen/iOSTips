//
//  Theme.swift
//  DCTheme
//
//  Created by Dariel on 2018/10/9.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

protocol Theme {
    
    var tint: UIColor { get }
    var barStyle: UIBarStyle { get }
    
    var labelColor: UIColor { get }
    var labelSelectedColor: UIColor { get }
    
    var backgroundColor: UIColor { get }
    var separatorColor: UIColor { get }
    var selectedColor: UIColor { get }
    
    func apply(for application: UIApplication)
    func extend()
}

extension Theme {
    
    func apply(for application: UIApplication) {
        application.keyWindow?.tintColor = tint
        
        
        UITabBar.appearance().with {
            $0.barTintColor = tint
            $0.tintColor = labelColor
        }
        
        UITabBarItem.appearance().with {
            $0.setTitleTextAttributes([.foregroundColor : labelColor], for: .normal)
            $0.setTitleTextAttributes([.foregroundColor : labelSelectedColor], for: .selected)
        }
        

        UINavigationBar.appearance().with {
            $0.barStyle = barStyle
            $0.tintColor = tint
            $0.barTintColor = tint
            $0.titleTextAttributes = [.foregroundColor : labelColor]
        }
        

        
        UITableView.appearance().with {
            $0.backgroundColor = backgroundColor
            $0.separatorColor = separatorColor
        }
        
        UITableViewCell.appearance().with {
            $0.backgroundColor = .clear
            $0.selectedColor = selectedColor
        }
        
        
        UIView.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]).backgroundColor = backgroundColor
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]).textColor = labelColor
        
        
        BackgroundView.appearance().with {
            $0.backgroundColor = backgroundColor
        }
        
        UISlider.appearance().with {
            $0.tintColor = tint
        }
        
        UISegmentedControl.appearance().with {
            $0.tintColor = tint
            $0.setTitleTextAttributes([.foregroundColor : labelColor], for: .normal)
            $0.setTitleTextAttributes([.foregroundColor : labelSelectedColor], for: .selected)
        }
        
        UIStackView.appearance().with {
            $0.tintColor = UIColor.clear
        }

        UILabel.appearance().textColor = labelColor
        
        UIButton.appearance().with {
            $0.setTitleColor(labelColor, for: .normal)
            $0.setTitleColor(selectedColor, for: .selected)
            $0.borderColor = labelColor
            $0.borderWidth = 1
            $0.cornerRadius = 3
        }
        
        UITextField.appearance().with {
            $0.backgroundColor = selectedColor
            $0.tintColor = tint
            $0.textColor = labelColor
        }
        
        UITextView.appearance().with {
            $0.backgroundColor = selectedColor
            $0.tintColor = tint
            $0.textColor = labelColor
        }
        
        extend()
        
        // 刷新所有控件
        application.windows.forEach { $0.reload() }
    }
    
    // 只要在
    func extend() {
        // 在主题中实现相关定制功能
    }
}
