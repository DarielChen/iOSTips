//
//  UITableViewCell+Extension.swift
//  DCTheme
//
//  Created by Dariel on 2018/10/10.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

extension UITableViewCell {
    /// cell选中时的颜色
    @objc dynamic var selectedColor: UIColor? {
        get { return selectedBackgroundView?.backgroundColor }
        set {
            guard selectionStyle != .none else { return }
            selectedBackgroundView = UIView().with {
                $0.backgroundColor = newValue
            }
        }
    }
}
