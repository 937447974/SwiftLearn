//
//  YJSelectTableViewController.swift
//  YJSocial
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/25.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// 数据交互协议
protocol YJProtoloc: NSObjectProtocol {
    
    func passValue(sender:UIViewController, values:[String:String])
}

class YJSelectTableViewController: UITableViewController {
    
    /// 所选择的数据
    private let data = ["阳君", "937447974"]
    /// 交互协议
    weak var delagete: YJProtoloc?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "reuseIdentifier")
        }
        cell!.textLabel?.text = self.data[indexPath.row]
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let values = ["value": self.data[indexPath.row]]
        self.delagete?.passValue(self, values: values)
    }
    
}
