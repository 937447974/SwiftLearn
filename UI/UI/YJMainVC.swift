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
        self.data.append(YJViewStyle.UITableView)
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
        let vc = self.data[indexPath.row].segueViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

/// 显示的View
private enum YJViewStyle: String {
    
    case UITableView
    case UICollectionView
    
    /// 获取标题
    func title() -> String {
        return "\(self)"
    }
    
    /// 获取UIViewController
    func segueViewController() -> UIViewController {
        var vc: UIViewController!
        let storyboard: UIStoryboard?
        // vc = YJUICollectionViewVC()
        switch self {
        case .UITableView, .UICollectionView:
            storyboard = UIStoryboard(name: self.title(), bundle: nil)
        }
        // vc 处理
        if vc != nil { // 代码生成VC
            vc.view.backgroundColor = UIColor.whiteColor() // 设置背景才会显示
        } else { // UIStoryboard中获取VC
            vc = storyboard?.instantiateInitialViewController()
            if let nc = vc as? UINavigationController { // 入口为UINavigationController
                vc = nc.topViewController
            }
        }
        return vc
    }
}
