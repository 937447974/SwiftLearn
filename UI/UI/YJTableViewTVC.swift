//
//  YJTableViewTVC.swift
//  UI
//
//  Created by yangjun on 15/12/14.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// 显示的View
private enum YJTableViewStyle: String {
    
    case UITableViewDelegate
    case UITableViewDataSource
    case UITableViewCell
    
    /// 获取标题
    func title() -> String {
        return "\(self)"
    }
    
    /// 获取UIViewController
    func segueIdentifier() -> String {
        return "\(self)"
    }
}

/// UITableView主界面
class YJTableViewTVC: UITableViewController {
    
    /// 数据源
    private var data = [YJTableViewStyle]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.data.append(YJTableViewStyle.UITableViewDataSource)
        self.data.append(YJTableViewStyle.UITableViewDelegate)
        self.data.append(YJTableViewStyle.UITableViewCell)
    }

    // MARK: - UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        cell?.textLabel?.text = self.data[indexPath.row].title()
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let identifier: String = self.data[indexPath.row].segueIdentifier()
        self.performSegueWithIdentifier(identifier, sender: nil)
    }

}

