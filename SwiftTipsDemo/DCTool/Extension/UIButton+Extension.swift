//
//  UIButton+Extension.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/10/18.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

private var actionDictKey: Void?
public typealias ButtonAction = (UIButton) -> Void

extension UIButton {
    // MARK: - 属性
    // 用于保存所有事件对应的闭包
    private var actionDict: [String: ButtonAction]? {
        get {
            return objc_getAssociatedObject(self, &actionDictKey) as? [String: ButtonAction]
        }
        set {
            objc_setAssociatedObject(self, &actionDictKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    // MARK: - API
    @discardableResult
    public func addTouchUpInsideAction(_ action: @escaping ButtonAction) -> UIButton {
        self.addButton(action: action, for: .touchUpInside)
        return self
    }
    @discardableResult
    public func addTouchUpOutsideAction(_ action: @escaping ButtonAction) -> UIButton {
        self.addButton(action: action, for: .touchUpOutside)
        return self
    }
    @discardableResult
    public func addTouchDownAction(_ action: @escaping ButtonAction) -> UIButton {
        self.addButton(action: action, for: .touchDown)
        return self
    }
    // MARK: - 私有方法
    private func addButton(action: @escaping ButtonAction, for controlEvents: UIControl.Event) {
        let eventKey = String(controlEvents.rawValue)
        if var actionDict = self.actionDict {
            actionDict.updateValue(action, forKey: eventKey)
            self.actionDict = actionDict
        } else {
            self.actionDict = [eventKey: action]
        }
        switch controlEvents {
        case .touchUpInside:
            addTarget(self, action: #selector(touchUpInsideControlEvent), for: .touchUpInside)
        case .touchUpOutside:
            addTarget(self, action: #selector(touchUpOutsideControlEvent), for: .touchUpOutside)
        case .touchDown:
            addTarget(self, action: #selector(touchDownControlEvent), for: .touchDown)
        default:
            break
        }
    }
    // 响应事件
    @objc private func touchUpInsideControlEvent() {
        executeControlEvent(.touchUpInside)
    }
    @objc private func touchUpOutsideControlEvent() {
        executeControlEvent(.touchUpOutside)
    }
    @objc private func touchDownControlEvent() {
        executeControlEvent(.touchDown)
    }
    private func executeControlEvent(_ event: UIControl.Event) {
        let eventKey = String(event.rawValue)
        if let actionDict = self.actionDict, let action = actionDict[eventKey] {
            action(self)
        }
    }
}
