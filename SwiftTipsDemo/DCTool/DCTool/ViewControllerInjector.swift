//
//  ViewDidLoadInjector.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/10/17.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit
import ObjectiveC.runtime

class ViewControllerInjector {
    
    typealias methodRef = @convention(c)(UIViewController, Selector) -> Void
    
    static func inject(into supportedClasses: [UIViewController.Type], selector: Selector, injection: @escaping (UIViewController) -> Void) {
        
        guard let originalMethod = class_getInstanceMethod(UIViewController.self, selector) else {
            fatalError("\(selector) must be implemented")
        }
        
        var originalIMP: IMP? = nil
        
        let swizzledViewDidLoadBlock: @convention(block) (UIViewController) -> Void = { receiver in
            if let originalIMP = originalIMP {
                let castedIMP = unsafeBitCast(originalIMP, to: methodRef.self)
                castedIMP(receiver, selector)
            }
            
            if ViewControllerInjector.canInject(to: receiver, supportedClasses: supportedClasses) {
                injection(receiver)
            }
        }
        
        let swizzledIMP = imp_implementationWithBlock(unsafeBitCast(swizzledViewDidLoadBlock, to: AnyObject.self))
        originalIMP = method_setImplementation(originalMethod, swizzledIMP)
    }
    
    
    private static func canInject(to receiver: Any, supportedClasses: [UIViewController.Type]) -> Bool {
        let supportedClassesIDs = supportedClasses.map { ObjectIdentifier($0) }
        let receiverType = type(of: receiver)
        return supportedClassesIDs.contains(ObjectIdentifier(receiverType))
    }
}
