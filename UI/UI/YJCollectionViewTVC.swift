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
        
        let cViewLayout = UICollectionViewLayout()
        var list = [YJPerformSegueModel]()
        var model = YJPerformSegueModel(title: "UICollectionViewDataSource") { () -> UIViewController? in
            let vc = YJCollectionViewDataSourceVC(collectionViewLayout: cViewLayout)
            vc.collectionView?.backgroundColor = UIColor.whiteColor()
            return vc
        }
        list.append(model)
        model = YJPerformSegueModel(title: "UICollectionViewDelegate") { () -> UIViewController? in
            let vc = YJCollectionViewDelegateVC(collectionViewLayout: cViewLayout)
            vc.collectionView?.backgroundColor = UIColor.whiteColor()
            return vc
        }
        list.append(model)
        self.data.append(list)
        self.header.append("默认")
        
        list = [YJPerformSegueModel]()
        model = YJPerformSegueModel(title: "UICollectionViewCell") { () -> UIViewController? in
            let vc = YJCollectionViewCellVC(collectionViewLayout: cViewLayout)
            vc.collectionView?.backgroundColor = UIColor.whiteColor()
            return vc
        }
        list.append(model)
        
        model = YJPerformSegueModel(title: "UICollectionViewLayout") { () -> UIViewController? in
            let vc = YJCollectionViewLayoutVC(collectionViewLayout: cViewLayout)
            vc.collectionView?.backgroundColor = UIColor.whiteColor()
            return vc
        }
        list.append(model)
        self.data.append(list)
        self.header.append("自定义")
        
    }

}
