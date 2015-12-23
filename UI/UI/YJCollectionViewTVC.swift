//
//  YJCollectionViewTVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/19.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// UICollectionView主界面
class YJCollectionViewTVC: YJBaseTVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.header.append("默认")
        var list = [YJPerformSegueModel]()
        list.append(YJPerformSegueModel(title: "UICollectionViewDataSource", storyboardName: nil, identifier: "DataSource"))
        list.append(YJPerformSegueModel(title: "UICollectionViewDelegate", storyboardName: nil, identifier: "Delegate"))
        list.append(YJPerformSegueModel(title: "UICollectionViewDelegateFlowLayout", storyboardName: nil, identifier: "DelegateFlowLayout"))
        self.data.append(list)
        
        self.header.append("自定义")
        list = [YJPerformSegueModel]()
        list.append(YJPerformSegueModel(title: "UICollectionViewCell", storyboardName: nil, identifier: "Cell"))
        list.append(YJPerformSegueModel(title: "UICollectionViewLayout", storyboardName: nil, identifier: "FlowLayout"))
        self.data.append(list)
    }

}
