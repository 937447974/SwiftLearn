//
//  YJToolbarVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/8.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// 定制UIToolBar
class YJToolbarVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 自定义UINavigationBar
        if let bar = self.navigationController?.toolbar { // 共享bar UIToolBar.appearance()
            bar.tintColor = UIColor.blackColor() // 按钮颜色
            bar.barTintColor = UIColor.yellowColor()// 背景色
            bar.translucent = false // 是否透明
        }
        // 显示toolbar
        self.navigationController?.toolbarHidden = false
        // 添加按钮
        self.toolbarItems = [UIBarButtonItem(barButtonSystemItem: .Search, target: nil, action: nil)]
    }

}
