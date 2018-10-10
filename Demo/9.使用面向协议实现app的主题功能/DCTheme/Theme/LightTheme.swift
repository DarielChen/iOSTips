//
//  LightTheme.swift
//  DCTheme
//
//  Created by Dariel on 2018/10/9.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

struct LightTheme: Theme {
   
    let tint: UIColor = .white
    let barStyle: UIBarStyle = .default
    
    let labelColor: UIColor = UIColor.darkText
    let labelSelectedColor: UIColor = UIColor.lightText
    
    let backgroundColor: UIColor = .white
    let separatorColor: UIColor = .lightGray
    let selectedColor: UIColor = UIColor(236, 236, 236)

}

extension LightTheme {
    
    // 需要自定义的部分写在这边
    func extend() {
        
        UISegmentedControl.appearance().with {
            $0.tintColor = UIColor.darkText
            $0.setTitleTextAttributes([.foregroundColor : labelColor], for: .normal)
            $0.setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        }
        
        UISlider.appearance().tintColor = UIColor.darkText
    }
}
