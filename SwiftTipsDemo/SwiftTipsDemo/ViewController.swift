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
        
        view.name = "123456789"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print(view.name ?? " ")
    
    }
}
