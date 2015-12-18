//
//  YJAutoLayoutTVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/18.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// Auto Layout 主界面
class YJAutoLayoutTVC: YJBaseTVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Auto Layout"
        var list = [YJPerformSegueModel]()
        list.append(YJPerformSegueModel(title: "NSLayoutConstraint"){YJAutoLayoutConstraintVC()})
        list.append(YJPerformSegueModel(title: "NSLayoutAnchor"){YJAutoLayoutAnchorVC()})
        list.append(YJPerformSegueModel(title: "UIStoryboard", storyboardName: "AutoLayout", identifier: nil))
        self.data.append(list)
    }

}
