//
//  UIView+Extensions.swift
//  EditingCollectionView
//
//  Created by Dariel on 2019/1/8.
//  Copyright © 2019年 Dariel. All rights reserved.
//

import UIKit

extension UIView {

    func pinEdgesToSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }
}
