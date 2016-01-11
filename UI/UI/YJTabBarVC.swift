//
//  YJTabBarVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/8.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// 定制UITabBar
class YJTabBarVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.toolbarItems = [UIBarButtonItem(barButtonSystemItem: .Search, target: nil, action: nil)]
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 自定义UITabBar
        if let bar = self.tabBarController?.tabBar { // 共享bar UITabBar.appearance()
            bar.tintColor = UIColor.blackColor() // 按钮颜色
            bar.barTintColor = UIColor.yellowColor()// 背景色
            bar.translucent = false // 是否透明
            bar.hidden = false
        }
    }
    
}
