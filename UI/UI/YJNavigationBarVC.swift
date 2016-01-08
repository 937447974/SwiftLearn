//
//  YJNavigationBarVC.swift
//  UI
//
//  Created by yangjun on 16/1/8.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// 定制UINavigationBar
class YJNavigationBarVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let bar = UINavigationBar.appearance()
        bar.tintColor = UIColor.blackColor() // 按钮颜色
        bar.barTintColor = UIColor.yellowColor()// 背景色
        // 标题样式
        bar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor()];
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 在新界面展示效果
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        self.navigationController?.presentViewController(vc!, animated: true, completion: nil)
    }
    
}
