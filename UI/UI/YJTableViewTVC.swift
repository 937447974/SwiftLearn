//
//  YJTableViewTVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/14.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// UITableView主界面
class YJTableViewTVC: YJBaseTVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.data.append(YJPerformSegueModel(title: "UITableViewDataSource", storyboardName: nil, identifier: "UITableViewDataSource"))
        self.data.append(YJPerformSegueModel(title: "UITableViewDelegate", storyboardName: nil, identifier: "UITableViewDelegate"))
        self.data.append(YJPerformSegueModel(title: "UITableViewCell", storyboardName: nil, identifier: "UITableViewCell"))
    }

}

