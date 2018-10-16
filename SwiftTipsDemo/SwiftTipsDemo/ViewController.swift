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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        navigationController?.pushViewController(ChildViewController(), animated: true)
        present(ChildViewController(), animated: true, completion: nil)
    }
}
