//
//  YJTableViewDataSourceVC.swift
//  UI
//
//  Created by yangjun on 15/12/14.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// TableViewDataSource展示
class YJTableViewDataSourceVC: UIViewController, UITableViewDataSource {

    /// 数据源
    var data = [[Int]]()
    
    @IBOutlet weak var tableView: UITableView!
    
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
    
    // 每一组有几个元素
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    // 生成Cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "\(self.data[indexPath.section][indexPath.row])"
        return cell!
    }
    
    // MARK: 组Header
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section)--Header"
    }

    // MARK: 组Footer
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "\(section)--Footer"
    }
    
    // MARK: 索引
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        var sectionTitles = [String]()
        for i in 0..<self.data.count {
            sectionTitles.append("\(i)")
        }
        return sectionTitles
    }
    
    // MARK: 索引对应的组
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return Int(title) ?? 0
    }
    
    // MARK: 能否编辑
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print(__FUNCTION__)
    }

    // MARK: 能否移动
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        print(__FUNCTION__)
        
    }
    
}
