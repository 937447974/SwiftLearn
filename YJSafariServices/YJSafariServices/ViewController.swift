//
//  ViewController.swift
//  YJSafariServices
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/21.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.testSFContentBlockerManager()
    }
    
    // MARK: - SFContentBlockerManager
    func testSFContentBlockerManager() {
        // SFContentBlockerManager 测试
        SFContentBlockerManager.reloadContentBlockerWithIdentifier(YJUtilsAPP.identifier) { (error: NSError?) -> Void in
            if error != nil {
                print(error)
            }
        }
    }

    // MARK: - SSReadingList {
    func testSSReadingList() {
        // SSReadingList测试
        guard let url = NSURL(string: "https://www.baidu.com") else { // 生成url
            return
        }
        guard SSReadingList.supportsURL(url) else { // 是否支持添加该链接
            return
        }
        do {
            // 添加到阅读列表
            try SSReadingList.defaultReadingList()?.addReadingListItemWithURL(url, title: "title", previewText: "previewText")
        } catch SSReadingListErrorCode.URLSchemeNotAllowed {
            print(SSReadingListErrorDomain)
        } catch {
            print(error)
        }
    }

    // MARK: - SFSafariViewController
    @IBAction func onClickButton(sender: AnyObject) {
        guard let url = NSURL(string: "https://developer.apple.com/library/ios/documentation/SafariServices/Reference/SFSafariViewController_Ref/index.html") else {
            return
        }
        let vc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
        vc.delegate = self
        self.presentViewController(vc, animated: true, completion: nil)
    }

    // MARK: - SFSafariViewControllerDelegate
    // MARK: web页面加载完成
    func safariViewController(controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        print(__FUNCTION__)
        print(didLoadSuccessfully)
    }
    
    func safariViewController(controller: SFSafariViewController, activityItemsForURL URL: NSURL, title: String?) -> [UIActivity] {
        print(__FUNCTION__)
        print("\(URL)--\(title)")
        return [YJUIActivity()]
    }
    
    // MARK: 退出页面
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        print(__FUNCTION__)
    }
    
}

/// 共享按钮
private class YJUIActivity: UIActivity {
    
    private override func activityTitle() -> String? {
        return "阳君"
    }
    
}

