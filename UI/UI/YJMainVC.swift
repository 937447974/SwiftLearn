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
    private var data = [YJMainCellStyle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.data.append(YJMainCellStyle.UICollectionView)
    }

    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        cell?.textLabel?.text = "\(self.data[indexPath.row])"
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var vc: UIViewController!
        // 根据样式显示VC
        switch self.data[indexPath.row] {
        case YJMainCellStyle.UICollectionView:
            vc = YJUICollectionViewVC()
        }
        // 设置白背景才会显示
        vc.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

/// 下一级页面显示的样式
private enum YJMainCellStyle: String {
    case UICollectionView
}
