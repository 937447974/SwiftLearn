//
//  YJTableViewDataSourceVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/14.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// TableViewDataSource展示
class YJTableViewDataSourceVC: UIViewController, UITableViewDataSource {
    
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
    
    // MARK: - 开起和关闭tableView编辑状态
    @IBAction func onClickEdit(sender: AnyObject) {
        self.tableView.setEditing(!self.tableView.editing, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    // MARK: 有几组
    func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        print(#function)
        return self.data.count
    }
    
    // MARK: 每一组有几个元素
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return self.data[section].count
    }
    
    // MARK: 生成Cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(#function)
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "\(self.data[indexPath.section][indexPath.row])"
        return cell!
    }
    
    // MARK: 组Header
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print(#function)
        return "\(section)--Header"
    }
    
    // MARK: 组Footer
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        print(#function)
        return "\(section)--Footer"
    }
    
    // MARK: 索引
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        print(#function)
        var sectionTitles = [String]()
        for i in 0..<self.data.count {
            sectionTitles.append("\(i)")
        }
        return sectionTitles
    }
    
    // MARK: 索引对应的组
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        print(#function)
        return Int(title) ?? 0
    }
    
    // MARK: 能否编辑
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        print(#function)
        return true
    }
    
    // MARK: 增加和删除
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print(#function)
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.data[indexPath.section].removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: 能否移动
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        print(#function)
        return true
    }
    
    // MARK: 移动cell
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        print(#function)
        // 处理源数据
        let sourceData = self.data[sourceIndexPath.section][sourceIndexPath.row]
        self.data[sourceIndexPath.section].removeAtIndex(sourceIndexPath.row)
        self.data[destinationIndexPath.section].insert(sourceData, atIndex: destinationIndexPath.row)
    }
    
}
