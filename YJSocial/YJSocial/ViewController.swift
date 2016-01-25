//
//  ViewController.swift
//  YJSocial
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/24.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import Social

/// 快速分享
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        // 分享到当前应用扩展（微博分享SLServiceTypeSinaWeibo）
        let serviceType = "com.YJSocial.ShareExtension" // 扩展Bundle identifier
        guard SLComposeViewController.isAvailableForServiceType(serviceType) else {
            print("不支持:\(serviceType)")
            return
        }
        let vc = SLComposeViewController(forServiceType: serviceType)
        vc.setInitialText(serviceType) // 默认内容
        // 处理结果回调
        vc.completionHandler =  {(result: SLComposeViewControllerResult) -> Void in
            switch result {
            case SLComposeViewControllerResult.Cancelled:
                print("Cancelled")
            case SLComposeViewControllerResult.Done:
                print("Done")
            }
        }
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
}

