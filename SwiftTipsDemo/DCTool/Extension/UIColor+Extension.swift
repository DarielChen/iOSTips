//
//  UIColor+Extension.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/10/9.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var darkNight: UIColor {
        return UIColor(2, 21, 51)
    }
    
    public convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}

