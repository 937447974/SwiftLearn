//
//  YJNavigationController.swift
//  ViewRotation
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/25.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// 横竖屏配置
class YJNavigationController: UINavigationController {

    // MARK: - Configuring the View Rotation Settings
    // MARK: 视图是否自动旋转
    override func shouldAutorotate() -> Bool {
        print("YJNavigationController.swift----\(__FUNCTION__)")
        return self.viewControllers.last!.shouldAutorotate()
    }
    
    // MARK: 返回视图支持的旋转方向
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        print("YJNavigationController.swift----\(__FUNCTION__)")
        return self.viewControllers.last!.supportedInterfaceOrientations()
    }
    
    // MARK: 上个界面跳转过来，支持的显示方向
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        // 只支持UIViewController.presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
        // 或 UINavigationController.showDetailViewController(vc, sender: nil)
        print("YJNavigationController.swift----\(__FUNCTION__)")
        return self.viewControllers.last!.preferredInterfaceOrientationForPresentation()
    }

}
