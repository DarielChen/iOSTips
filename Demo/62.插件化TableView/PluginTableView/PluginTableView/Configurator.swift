//
//  Configurator.swift
//  PluginTableView
//
//  Created by Dariel on 2019/8/7.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

protocol ConfiguratorType {
    associatedtype Item
    associatedtype Cell: UITableViewCell
    
    func reuseIdentifier(for item: Item, indexPath: IndexPath) -> String
    func registerCells(in tableView: UITableView)
    func configure(cell: Cell, item: Item, tableView: UITableView, indexPath: IndexPath) -> Cell
    
}
extension ConfiguratorType {
    
    func configuredCell(for item: Item, tableView: UITableView, indexPath: IndexPath) -> Cell {
        let reuseIdentifier = self.reuseIdentifier(for: item, indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Cell
        return self.configure(cell: cell, item: item, tableView: tableView, indexPath: indexPath)
    }
}
struct Configurator<Item, Cell: UITableViewCell>: ConfiguratorType {
    
    func configure(cell: Cell, item: Item, tableView: UITableView, indexPath: IndexPath) -> Cell {
        return configurator(cell, item, tableView, indexPath)
    }
    
    typealias CellConfigurator = (Cell, Item, UITableView, IndexPath) -> Cell
    
    let configurator: CellConfigurator
    let reuseIdentifier = "\(Cell.self)"
    
    func reuseIdentifier(for item: Item, indexPath: IndexPath) -> String {
        return reuseIdentifier
    }
    
    func registerCells(in tableView: UITableView) {
        if let path = Bundle.main.path(forResource: "\(Cell.self)", ofType: "nib"),
            FileManager.default.fileExists(atPath: path) {
            let nib = UINib(nibName: "\(Cell.self)", bundle: .main)
            tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        } else {
            tableView.register(Cell.self, forCellReuseIdentifier: reuseIdentifier)
        }
    }
}
