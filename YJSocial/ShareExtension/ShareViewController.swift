//
//  ShareViewController.swift
//  ShareExtension
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/24.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController, YJProtoloc {
    
    /// 选择器的值
    fileprivate var value = ""
    /// 附件照片
    var attachedImage: UIImage?
    
    // MARK: 内容校验
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        print(#function)
        let messageLength = self.contentText.lengthOfBytes(using: String.Encoding.utf8)
        let cRemaining = 100 - messageLength
        self.charactersRemaining = NSNumber(value: cRemaining as Int)
        
        return cRemaining >= 0
    }
    
    // MARK: 点击发布
    override func didSelectPost() {
        print(#function)
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        // Perform the post operation.
        // When the operation is complete (probably asynchronously), the Share extension should notify the success or failure, as well as the items that were actually shared.
        // 添加传输数据
        let item = NSExtensionItem()
        item.attributedContentText = NSAttributedString(string: self.contentText)
        var list = self.extensionContext?.inputItems
        list?.append(item)
        print(self.extensionContext)
        self.extensionContext!.completeRequest(returningItems: list) { (success: Bool) -> Void in
            print(success)
        }
    }
    
    // MARK: 选择器
    override func configurationItems() -> [Any]! {
        print(#function)
        let item = SLComposeSheetConfigurationItem()
        item?.title = "选择"
        item?.value = self.value
        item?.tapHandler = {
            let vc = YJSelectTableViewController(style: UITableViewStyle.grouped)
            vc.delagete = self
            self.pushConfigurationViewController(vc)
        }
        return [item]
    }
    
    override func presentationAnimationDidFinish() {
        super.presentationAnimationDidFinish()
        print(#function)
        // 解析数据
        guard let items = self.extensionContext?.inputItems as? [NSExtensionItem] else {
            print("解析出错")
            return
        }
        for item in items {
            if let providers = item.attachments as? [NSItemProvider] {
                for provider in providers {
                    if provider.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
                        provider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil, completionHandler: { (url:NSSecureCoding?, erroe: NSError!) -> Void in
                            print(url)
                        })
                    }
                }
            }
        }
        
    }
    
    // MARK: - YJProtoloc
    func passValue(_ sender: UIViewController, values: [String : String]) {
        self.popConfigurationViewController()
        if let data = values["value"] {
            self.value = data
            self.reloadConfigurationItems()
        }
    }
    
}
