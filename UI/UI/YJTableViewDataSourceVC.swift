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
    @IBAction func onClickEdit(_ sender: AnyObject) {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    // MARK: 有几组
    func numberOfSections(in tableView: UITableView) -> Int  {
        print(#function)
        return self.data.count
    }
    
    // MARK: 每一组有几个元素
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return self.data[section].count
    }
    
    // MARK: 生成Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "\(self.data[indexPath.section][indexPath.row])"
        return cell!
    }
    
    // MARK: 组Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print(#function)
        return "\(section)--Header"
    }
    
    // MARK: 组Footer
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        print(#function)
        return "\(section)--Footer"
    }
    
    // MARK: 索引
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        print(#function)
        var sectionTitles = [String]()
        for i in 0..<self.data.count {
            sectionTitles.append("\(i)")
        }
        return sectionTitles
    }
    
    // MARK: 索引对应的组
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        print(#function)
        return Int(title) ?? 0
    }
    
    // MARK: 能否编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        print(#function)
        return true
    }
    
    // MARK: 增加和删除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print(#function)
        if editingStyle == .delete {
            // Delete the row from the data source
            self.data[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: 能否移动
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        print(#function)
        return true
    }
    
    // MARK: 移动cell
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(#function)
        // 处理源数据
        let sourceData = self.data[sourceIndexPath.section][sourceIndexPath.row]
        self.data[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        self.data[destinationIndexPath.section].insert(sourceData, at: destinationIndexPath.row)
    }
    
}
