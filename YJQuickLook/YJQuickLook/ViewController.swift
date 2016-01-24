//
//  ViewController.swift
//  YJQuickLook
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/24.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import QuickLook

class ViewController: UIViewController, QLPreviewControllerDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - 点击屏幕
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        let qlVC = QLPreviewController()
        qlVC.dataSource = self
        qlVC.currentPreviewItemIndex = 0 // 显示第一个
        self.presentViewController(qlVC, animated: true, completion: nil)
    }
    
    // MARK: - QLPreviewControllerDataSource
    func numberOfPreviewItemsInPreviewController(controller: QLPreviewController) -> Int {
        print(__FUNCTION__)
        return 2
    }
    
    func previewController(controller: QLPreviewController, previewItemAtIndex index: Int) -> QLPreviewItem {
        print(__FUNCTION__)
        return YJPreviewItem()
    }
    
}

