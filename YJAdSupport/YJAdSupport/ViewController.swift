//
//  ViewController.swift
//  YJAdSupport
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/26.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import AdSupport

// 广告标示符
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let iManager = ASIdentifierManager.sharedManager() // 共享
        print(iManager.advertisingIdentifier) // 唯一标示符
        print(iManager.advertisingTrackingEnabled) // 用户是否允许跟踪
    }

}

