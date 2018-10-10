//
//  ViewController.swift
//  DCTheme
//
//  Created by Dariel on 2018/10/9.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.selectedSegmentIndex = 0
        LightTheme().apply(for: UIApplication.shared)
    }
    
    @IBAction func themeSegmentedControlChanged(_ sender: UISegmentedControl) {
        
        let theme: Theme
        switch sender.selectedSegmentIndex {
            case 0: theme = LightTheme()
            case 1: theme = BlueTheme()
            default: theme = DarkTheme()
        }
        theme.apply(for: UIApplication.shared)
    }

}

