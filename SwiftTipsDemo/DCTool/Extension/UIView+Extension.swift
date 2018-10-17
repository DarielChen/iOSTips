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


extension UIView {
    
    /// 添加点击手势 action: #selector(touchAction)
    public func addTapGesture(tapNumber: Int = 1, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    /// 添加点击手势,使用闭包回调   记得使用 [weak self]
    public func addTapGesture(tapNumber: Int = 1, action: ((UITapGestureRecognizer) -> Void)?) {
        let tap = ClosureTapGesture(tapCount: tapNumber, fingerCount: 1, action: action)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
}

private var nameKey: Void?

extension UIView {
    
    var name: String? {
        get {
            return objc_getAssociatedObject(self, &nameKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &nameKey, newValue,. OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}
