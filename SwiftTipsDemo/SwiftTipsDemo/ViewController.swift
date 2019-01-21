//
//  ViewController.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/9/28.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: .zero)
        label.text = "12321"
        label.textAlignment = .center
        label.backgroundColor = .red
        view.addSubview(label)
        
        label.layout {
            
            $0.aTop == view.aTop + 200
            $0.aLeading == view.aLeading + 20
            $0.aTrailing == view.aTrailing - 20
            $0.aHeight == 40
        
        }
        
    }
}
