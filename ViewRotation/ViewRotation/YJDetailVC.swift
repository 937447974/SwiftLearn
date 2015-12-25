//
//  YJDetailVC.swift
//  ViewRotation
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/25.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// 第二页
class YJDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 监听设备方向
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedRotation",
            name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //通知监听触发的方法
    func receivedRotation(){
        switch UIDevice.currentDevice().orientation { // 屏幕方向
        case UIDeviceOrientation.Unknown:
            print("方向未知")
        case .Portrait: // Device oriented vertically, home button on the bottom
            print("屏幕直立")
        case .PortraitUpsideDown: // Device oriented vertically, home button on the top
            print("屏幕倒立")
        case .LandscapeLeft: // Device oriented horizontally, home button on the right
            print("屏幕左在上方")
        case .LandscapeRight: // Device oriented horizontally, home button on the left
            print("屏幕右在上方")
        case .FaceUp: // Device oriented flat, face up
            print("屏幕朝上")
        case .FaceDown: // Device oriented flat, face down
            print("屏幕朝下")
        }
    }

    // MARK: - Configuring the View Rotation Settings
    // MARK: 视图是否自动旋转
    override func shouldAutorotate() -> Bool {
        print("YJDetailVC.swift----\(__FUNCTION__)")
        return super.shouldAutorotate()
    }
    // MARK: 返回视图支持的旋转方向
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        print("YJDetailVC.swift----\(__FUNCTION__)")
        return super.supportedInterfaceOrientations()
    }
    
    // MARK: 上个界面跳转过来，支持的显示方向
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        // 只支持UIViewController.presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
        // 或 UINavigationController.showDetailViewController(vc, sender: nil)
        print("YJDetailVC.swift----\(__FUNCTION__)")
        return UIInterfaceOrientation.LandscapeRight
    }

}
