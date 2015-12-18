//
//  YJAutoLayoutConstraintVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/18.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

class YJAutoLayoutConstraintVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 黄View
        let yellowView = UIView()
        yellowView.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(yellowView)
        // 绿View
        let greenView = UIView()
        greenView.backgroundColor = UIColor.greenColor()
        
//        Yellow View.Leading = Superview.LeadingMargin
//        Green View.Leading = Yellow View.Trailing + Standard
//        Green View.Trailing = Superview.TrailingMargin
//        Yellow View.Top = Top Layout Guide.Bottom + 20.0
//        Green View.Top = Top Layout Guide.Bottom + 20.0
//        Bottom Layout Guide.Top = Yellow View.Bottom + 20.0
//        Bottom Layout Guide.Top = Green View.Bottom + 20.0
//        Yellow View.Width = Green View.Width
//        NSLayoutConstraint(item: <#T##AnyObject#>, attribute: <#T##NSLayoutAttribute#>, relatedBy: <#T##NSLayoutRelation#>, toItem: <#T##AnyObject?#>, attribute: <#T##NSLayoutAttribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)

        
    }

    

}
