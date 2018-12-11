//
//  UIView+Extension.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/10/2.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

extension UIView {
    /// 同时添加多个子控件
    ///
    /// - Parameter subviews: 单个或多个子控件
    public func add(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    /// 设置顶部两个圆角
    ///
    /// - Parameter radius: 圆角半径
    public func topRoundCorners(radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:
            UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue),
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

public typealias GestureClosures = (UIGestureRecognizer) -> Void
private var gestureDictKey: Void?

extension UIView {
    private enum GestureType: String {
        case tapGesture
        case pinchGesture
        case rotationGesture
        case swipeGesture
        case panGesture
        case longPressGesture
    }

    // MARK: - 属性
    private var gestureDict: [String: GestureClosures]? {
        get {
            return objc_getAssociatedObject(self, &gestureDictKey) as? [String: GestureClosures]
        }
        set {
            objc_setAssociatedObject(self, &gestureDictKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    // MARK: - API
    /// 点击
    @discardableResult
    public func addTapGesture(_ gesture: @escaping GestureClosures) -> UIView {
        addGesture(gesture: gesture, for: .tapGesture)
        return self
    }
    /// 捏合
    @discardableResult
    public func addPinchGesture(_ gesture: @escaping GestureClosures) -> UIView {
        addGesture(gesture: gesture, for: .pinchGesture)
        return self
    }
    /// 旋转
    @discardableResult
    public func addRotationGesture(_ gesture: @escaping GestureClosures) -> UIView {
        addGesture(gesture: gesture, for: .rotationGesture)
        return self
    }
    /// 滑动
    @discardableResult
    public func addSwipeGesture(_ gesture: @escaping GestureClosures) -> UIView {
        addGesture(gesture: gesture, for: .swipeGesture)
        return self
    }
    /// 拖动
    @discardableResult
    public func addPanGesture(_ gesture: @escaping GestureClosures) -> UIView {
        addGesture(gesture: gesture, for: .panGesture)
        return self
    }
    /// 长按
    @discardableResult
    public func addLongPressGesture(_ gesture: @escaping GestureClosures) -> UIView {
        addGesture(gesture: gesture, for: .longPressGesture)
        return self
    }
    // MARK: - 私有方法
    private func addGesture(gesture: @escaping GestureClosures, for gestureType: GestureType) {
        let gestureKey = String(gestureType.rawValue)
        if var gestureDict = self.gestureDict {
            gestureDict.updateValue(gesture, forKey: gestureKey)
            self.gestureDict = gestureDict
        } else {
            self.gestureDict = [gestureKey: gesture]
        }
        isUserInteractionEnabled = true
        switch gestureType {
        case .tapGesture:
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(_:)))
            addGestureRecognizer(tap)
        case .pinchGesture:
            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureAction(_:)))
            addGestureRecognizer(pinch)
        case .rotationGesture:
            let rotation = UIRotationGestureRecognizer(target: self, action: #selector(rotationGestureAction(_:)))
            addGestureRecognizer(rotation)
        case .swipeGesture:
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction(_:)))
            addGestureRecognizer(swipe)
        case .panGesture:
            let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
            addGestureRecognizer(pan)
        case .longPressGesture:
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureAction(_:)))
            addGestureRecognizer(longPress)
        }
    }
    @objc private func tapGestureAction (_ tap: UITapGestureRecognizer) {
        executeGestureAction(.tapGesture, gesture: tap)
    }
    @objc private func pinchGestureAction (_ pinch: UIPinchGestureRecognizer) {
        executeGestureAction(.pinchGesture, gesture: pinch)
    }
    @objc private func rotationGestureAction (_ rotation: UIRotationGestureRecognizer) {
        executeGestureAction(.rotationGesture, gesture: rotation)
    }
    @objc private func swipeGestureAction (_ swipe: UISwipeGestureRecognizer) {
        executeGestureAction(.swipeGesture, gesture: swipe)
    }
    @objc private func panGestureAction (_ pan: UIPanGestureRecognizer) {
        executeGestureAction(.panGesture, gesture: pan)
    }
    @objc private func longPressGestureAction (_ longPress: UILongPressGestureRecognizer) {
        executeGestureAction(.longPressGesture, gesture: longPress)
    }
    private func executeGestureAction(_ gestureType: GestureType, gesture: UIGestureRecognizer) {
        let gestureKey = String(gestureType.rawValue)
        if let gestureDict = self.gestureDict, let gestureReg = gestureDict[gestureKey] {
            gestureReg(gesture)
        }
    }
}

extension UIView {
    private static var getAllsubviews: [UIView] = []
    public func getSubView(name: String) -> [UIView] {
        let viewArr = viewArray(root: self)
        UIView.getAllsubviews = []
        return viewArr.filter {$0.className == name}
    }
    public func getAllSubViews() -> [UIView] {
        UIView.getAllsubviews = []
        return viewArray(root: self)
    }
    private func viewArray(root: UIView) -> [UIView] {
        for view in root.subviews {
            if view.isKind(of: UIView.self) {
                UIView.getAllsubviews.append(view)
            }
            _ = viewArray(root: view)
        }
        return UIView.getAllsubviews
    }
}
