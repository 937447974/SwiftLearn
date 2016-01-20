//
//  TodayViewController.swift
//  TodayExtension
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/19.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        // 隐藏或显示界面
        NCWidgetController.widgetController().setHasContent(true, forWidgetWithBundleIdentifier: YJUtilsAPP.identifier)
        print(YJUtilsAPP.identifier)
        // 调整显示区域
        self.preferredContentSize = CGSizeMake(self.view.frame.width, 50)
        print(self.view.frame)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print(__FUNCTION__)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print(__FUNCTION__)
    }
    
    deinit {
        print("内存回收")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickButton(sender: AnyObject) {
        print(__FUNCTION__)
        // 数据同步
        if let user = NSUserDefaults(suiteName: "group.com.YJNotificationCenter") {
            print(user.objectForKey("test"))
            user.setObject("阳君测试", forKey: "test")
            print(user.synchronize())
        }
        // 打开当前应用
        if let url = NSURL(string: "appextension://test") {
            self.extensionContext?.openURL(url, completionHandler: { (success: Bool) -> Void in
                print("open url result: \(success)")
            })
        }
    }
    
    // MARK: - NCWidgetProviding
    // MARK: 当前状态
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        print(__FUNCTION__)
        completionHandler(NCUpdateResult.NewData)
    }
    
    // MARK: 扩展显示边缘
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        print(__FUNCTION__)
        print(defaultMarginInsets)
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
