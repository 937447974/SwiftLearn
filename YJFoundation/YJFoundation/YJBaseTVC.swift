//
//  YJBaseTVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/17.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// UITableViewController基类
open class YJBaseTVC: UITableViewController {
    
    /// 数据源
    var data = [[YJPerformSegueModel]]()
    var header = [String]()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UITableViewDataSource
    override open func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        cell?.textLabel?.text = self.data[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row].title
        return cell!
    }
    
    override open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.header.count > section ? self.header[section] : nil
    }
    
    // MARK: - UITableViewDelegate
    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.data[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row].performSegue(self)
    }
    
}
