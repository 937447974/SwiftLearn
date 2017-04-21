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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 自定义UINavigationBar
        if let bar = self.navigationController?.toolbar { // 共享bar UIToolBar.appearance()
            bar.tintColor = UIColor.black // 按钮颜色
            bar.barTintColor = UIColor.yellow// 背景色
            bar.isTranslucent = false // 是否透明
        }
        // 显示toolbar
        self.navigationController?.isToolbarHidden = false
        // 添加按钮
        self.toolbarItems = [UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)]
    }

}
