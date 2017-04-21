//
//  UITableView+Extension.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/14.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

public extension UITableView {
    
    // MARK: - 去掉tableHeaderView
    /// 去掉tableHeaderView
    ///
    /// - returns: void
    func removeTableHeaderView() {
        self.tableHeaderView = UIView(frame:  CGRect(x: 0, y: 0, width: YJUtilScreenSize.screenWidth, height: 0.1))
    }
    
    // MARK: - 去掉tableFooterView
    /// 去掉tableFooterView
    ///
    /// - returns: void
    func removeTableFooterView() {
        self.tableFooterView = UIView(frame:  CGRect(x: 0, y: 0, width: YJUtilScreenSize.screenWidth, height: 0.1))
    }
    
}
