//
//  UIView+Extension.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/10/2.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit


extension UIView {
    
    /// 同时添加多个子控件
    ///
    /// - Parameter subviews: 单个或多个子控件
    func add(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
