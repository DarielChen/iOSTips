//
//  PluginTableView.swift
//  PluginTableView
//
//  Created by Dariel on 2019/8/7.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit

class PluginTableView<Configurator: ConfiguratorType>: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView
    private let dataSource: DataSource<Configurator.Item>
    private let configurator: Configurator
    
    var didSelectRow: ((UITableView, IndexPath) -> Void)?
    
    init(frame: CGRect, style: UITableView.Style, dataSource: DataSource<Configurator.Item>, configurator: Configurator) {
        self.dataSource = dataSource
        self.configurator = configurator
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), style: style)
        super.init(frame: frame)
        
        tableView.dataSource = self
        tableView.delegate = self
        self.addSubview(tableView)
        configurator.registerCells(in: tableView)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - 数据源
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource.item(at: indexPath)
        return configurator.configuredCell(for: item, tableView: tableView, indexPath: indexPath)
    }
    
    // MARK: - 代理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow?(tableView, indexPath)
    }
    
    // ...
    
}
