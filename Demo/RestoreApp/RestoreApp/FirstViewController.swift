//
//  FirstViewController.swift
//  RestoreApp
//
//  Created by Dariel on 2019/6/19.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var sliderView: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restorationIdentifier = String(describing: type(of: self))
    }
    
    
}


extension FirstViewController {
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        guard let loadedSlider = sliderView, isViewLoaded else {
            return
        }
        coder.encode(loadedSlider.value, forKey: .encodingKeySliderValue)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        assert(isViewLoaded, "We assume the controller is never restored without loading its view first.")
        sliderView?.value = coder.decodeFloat(forKey: .encodingKeySliderValue)
    }
    
    override func applicationFinishedRestoringState() {
        print("Finished restoring everything.")
    }
}


fileprivate extension String {
    static let encodingKeySliderValue = "encodingKeySliderValue"
}

