//
//  LastViewController.swift
//  RestoreApp
//
//  Created by Dariel on 2019/6/19.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class LastViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationItem.title = "LastViewController"
        
        restorationIdentifier = "LastViewController"
        restorationClass = LastViewController.self
        
    }
    
    override func applicationFinishedRestoringState() {
        print("Finished restoring everything.")
    }
}

extension LastViewController: UIViewControllerRestoration {
    static func viewController(withRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
        let vc = LastViewController()
        return vc
    }
}
