//
//  YJPerformSegueModel.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/17.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// 可跳转的模型
public class YJPerformSegueModel {
    
    /// 标题
    let title: String!
    /// 前往下一页的identifier
    var identifier: String?
    /// storyboard名
    var storyboardName: String?
    /// 回调生成UIViewController
    var hander: (()->UIViewController?)?
    
    // MARK: - 初始化
    /// 初始化
    ///
    /// - parameter title : 标题
    ///
    /// - returns: YJCellModel
    init(title: String) {
        self.title = title
    }
    
    /// 初始化
    ///
    /// - parameter title : 标题
    /// - parameter storyboardName : storyboard名
    /// - parameter identifier : 前往下一页的identifier，对应performSegueWithIdentifier方法的identifier
    /// - parameter hander : 回调生成UIViewController
    ///
    /// - returns: YJCellModel
    init(title: String, storyboardName: String?, identifier: String?, hander: (()->UIViewController?)?) {
        self.title = title
        self.identifier = identifier
        self.storyboardName = storyboardName
        self.hander = hander
    }
    
    // MARK: - 跳转
    /// 跳转
    ///
    /// - parameter source : 要跳转的UIViewController
    ///
    /// - returns: void
    func performSegue(source: UIViewController) {
        if let vc = self.hander?() { // 1 定制UIViewController
            source.navigationController?.pushViewController(vc, animated: true)
        } else if self.storyboardName != nil && self.identifier != nil { // push跳转到Storyboard中指定UIViewController
            source.pushStoryboard(self.storyboardName!, identifier: self.identifier!, sender: nil)
        } else if self.storyboardName != nil { // push跳转到Storyboard
            source.pushStoryboard(self.storyboardName!, sender: nil)
        } else if self.identifier != nil { // 视图内跳转
            source.performSegueWithIdentifier(self.identifier!, sender: nil)
        } else { // 设置错误
            print("未设置跳转路径")
        }
    }
    
}
