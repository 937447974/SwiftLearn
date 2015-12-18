//
//  YJScrollViewTVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/17.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// UIScrollView主界面
class YJScrollViewTVC: YJBaseTVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var list = [YJPerformSegueModel]()
        list.append(YJPerformSegueModel(title: "UIScrollViewDelegate"){YJScrollViewDelegateVC()})
        list.append(YJPerformSegueModel(title: "纯代码AutoLayout"){YJAutoLayoutSVVC()})
        list.append(YJPerformSegueModel(title: "故事面板AutoLayout", storyboardName: nil, identifier: "AutoLayout"))
        self.data.append(list)
    }
    
}
