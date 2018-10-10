//
//  UIWindow+Extension.swift
//  DCTheme
//
//  Created by Dariel on 2018/10/10.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

public extension UIWindow {
    /// 刷新所有子控件
    func reload() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }
}
