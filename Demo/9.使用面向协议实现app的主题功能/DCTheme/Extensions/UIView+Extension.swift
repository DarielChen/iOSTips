//
//  UIView+Extension.swift
//  DCTheme
//
//  Created by Dariel on 2018/10/10.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

public extension UIView {
    
    /// 边框颜色
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            
            layer.borderColor = color.cgColor
        }
    }
    
    /// 边框宽度
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    /// 圆角半径
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }
}

