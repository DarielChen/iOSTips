//
//  UIWindow+Extension.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/10/9.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

extension UIWindow {
    /// 刷新所有的子控件
    func reload() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }
}
