//
//  YJTableViewDelegateVC.swift
//  UI
//
//  Created by yangjun on 15/12/14.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// UITableViewDelegate演示
class YJTableViewDelegateVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    /// 数据源
    var data = [[Int]]()
    /// UITableView
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - view
    override func viewDidLoad() {
        super.viewDidLoad()
        // 以组演示,填充相关测试数据
        var section = [Int]()
        for _ in 0..<5 {
            section.removeAll()
            for row in 0..<10 {
                section.append(row)
            }
            self.data.append(section)
        }
    }
    
    // MARK: - UITableViewDataSource
    // MARK: 有几组
    func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return self.data.count
    }
    
    // MARK: 每一组有几个元素
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    // MARK: 生成Cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            cell?.accessoryType = UITableViewCellAccessoryType.DetailButton
        }
        cell?.textLabel?.text = "\(self.data[indexPath.section][indexPath.row])"
        return cell!
    }

    // MARK: - UITableViewDelegate
    // MARK: - 配置行
    // MARK: 预获取行高
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // 实现此方法后,显示界面前func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloath不会执行，有助于提升显示效率
        print("\(__FUNCTION__)--\(indexPath)")
        return 44
    }
    
    // MARK: 行缩进
    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        print("\(__FUNCTION__)--\(indexPath)")
        return self.data[indexPath.section][indexPath.row]
    }
    
    // MARK: 行高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        print("\(__FUNCTION__)--\(indexPath)")
        // 默认44
        return 44
    }

    // MARK: 将要显示行
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        print("\(__FUNCTION__)--\(indexPath)")
    }
    
    // MARK: - Managing Accessory Views
    // MARK: 左滑出现的按钮
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        print("\(__FUNCTION__)--\(indexPath)")
        var action = [UITableViewRowAction]()
        let handler: (UITableViewRowAction, NSIndexPath) -> Void = {(action: UITableViewRowAction, indexPath: NSIndexPath) in
            print("\(indexPath)--\(action.title)")
        }
        action.append(UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Default", handler:handler))
        action.append(UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Destructive", handler:handler))
        action.append(UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Normal", handler:handler))
        return action
    }
    
    // MARK: 点击cell上的系统按钮
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        print("\(__FUNCTION__)--\(indexPath)")
    }

}
