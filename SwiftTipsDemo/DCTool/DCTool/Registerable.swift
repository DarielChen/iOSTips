//
//  Registerable.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2019/1/21.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

enum RegisterableView {
    case nib(NSObject.Type)
    case `class`(NSObject.Type)
}

extension RegisterableView {
    var nib: UINib? {
        switch self {
        case let .nib(cellClass):
            return UINib(nibName: String(describing: cellClass), bundle: nil)
        default:
            return nil
        }
    }
    var cellClass: AnyClass? {
        switch self {
        case let .class(cellClass):
            return cellClass
        default:
            return nil
        }
    }
}

protocol ClassIdentifiable {
    static func identifier() -> String
}
extension NSObject: ClassIdentifiable {
    static func identifier() -> String {
        return String(describing: self)
    }
}

extension RegisterableView {
    var identifier: String {
        switch self {
        case let .nib(cellClass):
            return cellClass.identifier()
        case let .class(cellClass):
            return cellClass.identifier()
        }
    }
}

protocol CollectionView {
    func register(cell: RegisterableView)
    func register(header: RegisterableView)
    func register(footer: RegisterableView)
}
extension CollectionView {
    // register cells
    func register(cells: [RegisterableView]) {
        cells.forEach(register(cell:))
    }
    // register headers
    func register(headers: [RegisterableView]) {
        headers.forEach(register(header:))
    }
    // register footers
    func register(footers: [RegisterableView]) {
        footers.forEach(register(footer:))
    }
}
extension UITableView: CollectionView {
    // register cell
    func register(cell: RegisterableView) {
        switch cell {
        case .nib:
            register(cell.nib, forCellReuseIdentifier: cell.identifier)
        case .class:
            register(cell.cellClass, forCellReuseIdentifier: cell.identifier)
        }
    }
    // register header
    func register(header: RegisterableView) {
        switch header {
        case .nib:
            register(header.nib, forHeaderFooterViewReuseIdentifier: header.identifier)
        case .class:
            register(header.cellClass, forHeaderFooterViewReuseIdentifier: header.identifier)
        }
    }
    // register footer
    func register(footer: RegisterableView) {
        register(header: footer)
    }
    // get reusableCell
    func dequeueCell<U: ClassIdentifiable>(at indexPath: IndexPath) -> U? {
        return dequeueReusableCell(withIdentifier: U.identifier(), for: indexPath) as? U
    }
}
extension UICollectionView: CollectionView {
    // register cell
    func register(cell: RegisterableView) {
        switch cell {
        case .nib:
            register(cell.nib, forCellWithReuseIdentifier: cell.identifier)
        case .class:
            register(cell.cellClass, forCellWithReuseIdentifier: cell.identifier)
        }
    }
    // register header
    func register(header: RegisterableView) {
        register(supplementaryView: header, kind: UICollectionView.elementKindSectionHeader)
    }
    // register footer
    func register(footer: RegisterableView) {
        register(supplementaryView: footer, kind: UICollectionView.elementKindSectionFooter)
    }
    func register(supplementaryView view: RegisterableView, kind: String) {
        switch view {
        case .nib:
            register(view.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: view.identifier)
        case .class:
            register(view.cellClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: view.identifier)
        }
    }
    // get reusableCell
    func dequeueCell<U: ClassIdentifiable>(at indexPath: IndexPath) -> U? {
        return dequeueReusableCell(withReuseIdentifier: U.identifier(), for: indexPath) as? U
    }
}
