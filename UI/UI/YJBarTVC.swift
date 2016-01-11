//
//  YJCustomizingBarTVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/8.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// Bar
class YJBarTVC: YJBaseTVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        var list = [YJPerformSegueModel]()
        list.append(YJPerformSegueModel(title: "UINavigationBar"){YJNavigationBarVC()})
        list.append(YJPerformSegueModel(title: "UIToolbar"){YJToolbarVC()})
        list.append(YJPerformSegueModel(title: "UITabBar"){YJTabBarVC()})
        self.data.append(list)
    }

}
