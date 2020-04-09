//
//  ViewController.swift
//  PresentPartController
//
//  Created by Dariel on 2020/4/8.
//  Copyright © 2020 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnTouch(_ sender: Any) {
        present(PresentPartController(), animated: true, completion: nil)

    }
    
}

