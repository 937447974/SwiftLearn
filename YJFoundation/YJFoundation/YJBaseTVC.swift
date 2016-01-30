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
public class YJBaseTVC: UITableViewController {
    
    /// 数据源
    var data = [[YJPerformSegueModel]]()
    var header = [String]()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UITableViewDataSource
    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.data.count
    }
    
    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        cell?.textLabel?.text = self.data[indexPath.section][indexPath.row].title
        return cell!
    }
    
    override public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.header.count > section ? self.header[section] : nil
    }
    
    // MARK: - UITableViewDelegate
    override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.data[indexPath.section][indexPath.row].performSegue(self)
    }
    
}
