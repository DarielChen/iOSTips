//
//  ClosureTapGesture.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/10/15.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

open class ClosureTapGesture: UITapGestureRecognizer {
    
    private var tapAction: ((UITapGestureRecognizer) -> Void)?
    
    public override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    public convenience init (
        tapCount: Int = 1,
        fingerCount: Int = 1,
        action: ((UITapGestureRecognizer) -> Void)?) {
        self.init()
        self.numberOfTapsRequired = tapCount
        
        self.numberOfTouchesRequired = fingerCount
        
        self.tapAction = action
        self.addTarget(self, action: #selector(ClosureTapGesture.didTap(_:)))
    }
    
    @objc open func didTap (_ tap: UITapGestureRecognizer) {
        tapAction? (tap)
    }
}
