//
//  YJNavigationBarVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/8.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// 定制UINavigationBar
class YJNavigationBarVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 自定义UINavigationBar
        if let bar = self.navigationController?.navigationBar { // 共享bar UINavigationBar.appearance()
            bar.tintColor = UIColor.blackColor() // 按钮颜色
            bar.barTintColor = UIColor.yellowColor()// 背景色
            bar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor()]; // 标题样式
            bar.translucent = false // 是否透明
            // 去掉UINavigationBar底部的黑边
            bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            bar.shadowImage = UIImage()
        }
    }
    
}
