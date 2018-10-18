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
    public convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}
