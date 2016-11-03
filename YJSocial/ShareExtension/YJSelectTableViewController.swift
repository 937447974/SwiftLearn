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
    
    func passValue(_ sender:UIViewController, values:[String:String])
}

class YJSelectTableViewController: UITableViewController {
    
    /// 所选择的数据
    fileprivate let data = ["阳君", "937447974"]
    /// 交互协议
    weak var delagete: YJProtoloc?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        }
        cell!.textLabel?.text = self.data[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let values = ["value": self.data[indexPath.row]]
        self.delagete?.passValue(self, values: values)
    }
    
}
