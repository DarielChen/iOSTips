//
//  UIColor+Extension.swift
//  DCTheme
//
//  Created by Dariel on 2018/10/10.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

extension UIColor {
    public class var darkNight: UIColor {
        return UIColor(2, 21, 40)
    }
    public class var dayBlue: UIColor {
        return UIColor(43, 89, 185)
    }
    public class var darkText: UIColor {
        return UIColor(75, 79, 103)
    }
    public class var lightText: UIColor {
        return UIColor(83, 115, 169)
    }
    public class var selectdLightBlue: UIColor {
        return UIColor(153, 189, 223)
    }
    public convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}
