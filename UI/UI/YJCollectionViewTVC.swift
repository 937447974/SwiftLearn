//
//  YJCollectionViewTVC.swift
//  UI
//
//  Created by yangjun on 15/12/19.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// UICollectionView主界面
class YJCollectionViewTVC: YJBaseTVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var list = [YJPerformSegueModel]()
        list.append(YJPerformSegueModel(title: "UICollectionViewDataSource", storyboardName: nil, identifier: "DataSource"))
        list.append(YJPerformSegueModel(title: "UICollectionViewDelegate", storyboardName: nil, identifier: "Delegate"))
        self.data.append(list)
        self.header.append("默认")
        
        list = [YJPerformSegueModel]()
        list.append(YJPerformSegueModel(title: "UICollectionViewCell", storyboardName: nil, identifier: "Cell"))
        list.append(YJPerformSegueModel(title: "UICollectionViewLayout", storyboardName: nil, identifier: "Layout"))
        self.data.append(list)
        self.header.append("自定义")
        
    }

}
