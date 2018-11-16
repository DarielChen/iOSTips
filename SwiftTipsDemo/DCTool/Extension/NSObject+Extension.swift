//
//  NSObject+Extension.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/10/19.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

public typealias NotificationClosures = (Notification) -> Void
private var notificationActionKey: Void?
public enum NotificationNameType: String {
    case notifyName1
    case notifyName2
}

extension NSObject {
    private var notificationClosuresDict: [NSNotification.Name: NotificationClosures]? {
        get {
            return objc_getAssociatedObject(self, &notificationActionKey)
                as? [NSNotification.Name: NotificationClosures]
        }
        set {
            objc_setAssociatedObject(self, &notificationActionKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    public func postNotification(_ name: NotificationNameType, userInfo: [AnyHashable: Any]?) {
        NotificationCenter.default.post(name: NSNotification.Name(name.rawValue), object: self, userInfo: userInfo)
    }
    public func observerNotification(_ name: NotificationNameType, action: @escaping NotificationClosures) {
        if var dict = notificationClosuresDict {
            guard dict[NSNotification.Name(name.rawValue)] == nil else {
                return
            }
            dict.updateValue(action, forKey: NSNotification.Name(name.rawValue))
            self.notificationClosuresDict = dict
        } else {
            self.notificationClosuresDict = [NSNotification.Name(name.rawValue): action]
        }
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAction),
                                               name: NSNotification.Name(name.rawValue), object: nil)
    }
    public func removeNotification(_ name: NotificationNameType) {
        NotificationCenter.default.removeObserver(self)
        notificationClosuresDict?.removeValue(forKey: NSNotification.Name(name.rawValue))
    }
    @objc func notificationAction(notify: Notification) {
        if let notificationClosures = notificationClosuresDict, let closures = notificationClosures[notify.name] {
            closures(notify)
        }
    }
}

extension NSObject {
    var className: String {
        let name = type(of: self).description()
        if name.contains(".") {
            return name.components(separatedBy: ".")[1]
        } else {
            return name
        }
    }
}
