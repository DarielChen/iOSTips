//
//  ChildViewController.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/10/16.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

class ChildViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
        let btn = ClosureButton()
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        btn.setTitle("按钮", for: .normal)
        view.addSubview(btn)
        
        btn.addAction { btn  in
            self.view.backgroundColor = UIColor.cyan
            
            print("\(type(of: self))")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        dch_checkDeallocation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
