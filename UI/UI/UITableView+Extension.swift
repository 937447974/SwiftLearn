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
    
    /// 去掉tableHeaderView
    ///
    /// - returns: void
    func removeTableHeaderView() {
        self.tableHeaderView = UIView(frame:  CGRectMake(0, 0, YJUtilScreenSize.screenWidth, 0.1))
    }
    
    /// 去掉tableFooterView
    ///
    /// - returns: void
    func removeTableFooterView() {
        self.tableFooterView = UIView(frame:  CGRectMake(0, 0, YJUtilScreenSize.screenWidth, 0.1))
    }
    
}
