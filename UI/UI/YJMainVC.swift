//
//  YJMainVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/12.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// 主界面
class YJMainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /// tableView
    @IBOutlet weak var tableView: UITableView!
    /// 数据源
    private var data = [[YJPerformSegueModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var list: [YJPerformSegueModel]!
        
        list = [YJPerformSegueModel]()
        list.append(YJPerformSegueModel(title: "Customizing Bar"){YJCustomizingBarTVC(style: UITableViewStyle.Grouped)})
        self.data.append(list)
        
        list = [YJPerformSegueModel]()
        list.append(YJPerformSegueModel(title: "Auto Layout"){YJAutoLayoutTVC(style: UITableViewStyle.Grouped)})
        self.data.append(list)
        
        list = [YJPerformSegueModel]()
        list.append(YJPerformSegueModel(title: "UIScrollView", storyboardName: "UIScrollView", identifier: nil))
        list.append(YJPerformSegueModel(title: "UITableView", storyboardName: "UITableView", identifier: nil))
        list.append(YJPerformSegueModel(title: "UICollectionView", storyboardName: "UICollectionView", identifier: nil))
        self.data.append(list)
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        cell?.textLabel?.text = self.data[indexPath.section][indexPath.row].title
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.data[indexPath.section][indexPath.row].performSegue(self)
    }
    
}
