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
    private var data = [YJViewStyle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.data.append(YJViewStyle.UICollectionView)
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
        cell?.textLabel?.text = self.data[indexPath.row].title()
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let style = self.data[indexPath.row]
        // 可以跳转则跳转
        if self.shouldPerformSegueWithIdentifier(style.segueIdentifier(), sender: nil) {
            self.performSegueWithIdentifier(style.segueIdentifier(), sender: nil)
            return
        }
        // 不能跳转则创建
        var vc: UIViewController!
        // 根据样式显示VC
        switch style {
        case YJViewStyle.UICollectionView:
            vc = YJUICollectionViewVC()
        }
        // 设置白背景才会显示
        vc.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

/// 显示的View
private enum YJViewStyle: String {
    
    case UICollectionView
    
    /// 获取标题
    func title() -> String {
        switch self {
        case .UICollectionView:
            return "UICollectionView"
        }
    }
    
    /// 获取identifier
    func segueIdentifier() -> String {
        switch self {
        case .UICollectionView:
            return "UICollectionView"
        }
    }
}
