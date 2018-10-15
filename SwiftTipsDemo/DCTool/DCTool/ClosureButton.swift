//
//  ClosureButton.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/10/15.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

public typealias ClosureButtonAction = (_ sender: ClosureButton) -> Void

/// 通过闭包实现按钮响应
open class ClosureButton: UIButton {
    
    // MARK: Propeties
//    open var highlightLayer: CALayer?
    open var action: ClosureButtonAction?
    
//    // MARK: Init
//    public init() {
//        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        defaultInit()
//    }
//
//    public init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
//        super.init(frame: CGRect(x: x, y: y, width: w, height: h))
//        defaultInit()
//    }
//
//    public init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, action: ClosureButtonAction?) {
//        super.init (frame: CGRect(x: x, y: y, width: w, height: h))
//        self.action = action
//        defaultInit()
//    }
//
//    public init(action: @escaping ClosureButtonAction) {
//        super.init(frame: CGRect.zero)
//        self.action = action
//        defaultInit()
//    }
//
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        defaultInit()
//    }
//
//    public init(frame: CGRect, action: @escaping ClosureButtonAction) {
//        super.init(frame: frame)
//        self.action = action
//        defaultInit()
//    }
//
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultInit()
    }
//
    private func defaultInit() {
//
        addTarget(self, action: #selector(ClosureButton.didPressed(_:)), for: UIControl.Event.touchUpInside)
//        addTarget(self, action: #selector(ClosureButton.highlight), for: [UIControl.Event.touchDown, UIControl.Event.touchDragEnter])
//        addTarget(self, action: #selector(ClosureButton.unhighlight), for: [
//            UIControl.Event.touchUpInside,
//            UIControl.Event.touchUpOutside,
//            UIControl.Event.touchCancel,
//            UIControl.Event.touchDragExit
//            ])
//        setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
//        setTitleColor(UIColor.lightGray, for: UIControl.State.selected)
//
    }
    
    /// 按钮响应方法
    open func addAction(_ action: @escaping ClosureButtonAction) {
        self.action = action
    }
    
    // MARK: Action
    @objc private func didPressed(_ sender: ClosureButton) {
        action?(sender)
    }
//
//    // MARK: Highlight
//    @objc open func highlight() {
//
//        if action == nil {
//            return
//        }
//
//        let highlightLayer = CALayer()
//        highlightLayer.frame = layer.bounds
//        highlightLayer.backgroundColor = UIColor.gray.cgColor
//        highlightLayer.opacity = 0.5
//        var maskImage: UIImage? = nil
//        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, false, 0)
//        if let context = UIGraphicsGetCurrentContext() {
//            layer.render(in: context)
//            maskImage = UIGraphicsGetImageFromCurrentImageContext()
//        }
//        UIGraphicsEndImageContext()
//        let maskLayer = CALayer()
//        maskLayer.contents = maskImage?.cgImage
//        maskLayer.frame = highlightLayer.frame
//        highlightLayer.mask = maskLayer
//        layer.addSublayer(highlightLayer)
//        self.highlightLayer = highlightLayer
//    }
//
//    @objc open func unhighlight() {
//        if action == nil {
//            return
//        }
//        highlightLayer?.removeFromSuperlayer()
//        highlightLayer = nil
//    }
}

