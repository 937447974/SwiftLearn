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

/// NSLayoutConstraint约束
class YJAutoLayoutConstraintVC: UIViewController {
    
    /*
    NSLayoutConstraint(item view1: AnyObject, attribute attr1: NSLayoutAttribute, relatedBy relation: NSLayoutRelation, toItem view2: AnyObject?, attribute attr2: NSLayoutAttribute, multiplier: CGFloat, constant c: CGFloat)
    遵循的原则，在UI上，
    1. 左边的View对应view1，右边的View对应view2；
    2. 下面的View对应View1，上面的View对应View2。
    口诀就是：前右下后左上
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1 添加View
        // 黄View
        let yellowView = UIView()
        yellowView.backgroundColor = UIColor.yellow
        self.view.addSubview(yellowView)
        // 绿View
        let greenView = UIView()
        greenView.backgroundColor = UIColor.green
        self.view.addSubview(greenView)
        
        // 2 开启AutoLayout
        yellowView.translatesAutoresizingMaskIntoConstraints  = false;
        greenView.translatesAutoresizingMaskIntoConstraints = false;
        
        // 3 设置约束
        /* 约束伪代码
        Yellow View.Leading = Superview.LeadingMargin
        Yellow View.Top = Top Layout Guide.Bottom + 20.0
        Bottom Layout Guide.Top = Yellow View.Bottom + 20.0
        
        Green View.Trailing = Superview.TrailingMargin
        Green View.Top = Top Layout Guide.Bottom + 20.0
        Bottom Layout Guide.Top = Green View.Bottom + 20.0
        
        Green View.Leading = Yellow View.Trailing + 30.0
        Yellow View.Width = Green View.Width
        */
        // 3.1 yellow约束, 多个添加
        let yLeading = NSLayoutConstraint(item: yellowView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leadingMargin, multiplier: 1.0, constant: 0)
        let yTop = NSLayoutConstraint(item: yellowView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 20.0)
        let yBottom = NSLayoutConstraint(item: self.bottomLayoutGuide, attribute: .top, relatedBy: .equal, toItem: yellowView, attribute: .bottom, multiplier: 1, constant: 20)
        self.view.addConstraints([yLeading, yTop, yBottom]) // 多个添加
        
        // 3.2 green约束,单一添加
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: .trailingMargin, relatedBy: .equal, toItem: greenView, attribute: .trailing, multiplier: 1.0, constant: 0)) // gTrailing
        self.view.addConstraint(NSLayoutConstraint(item: greenView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 20.0)) // gTop
        self.view.addConstraint(NSLayoutConstraint(item: self.bottomLayoutGuide, attribute: .top, relatedBy: .equal, toItem: greenView, attribute: .bottom, multiplier: 1, constant: 20)) // gBottom
        
        // 3.3 green和yellow的共有约束，直接执行
        NSLayoutConstraint(item: greenView, attribute: .leading, relatedBy: .equal, toItem: yellowView, attribute: .trailing, multiplier: 1, constant: 30).isActive = true // 间距
        NSLayoutConstraint(item: greenView, attribute: .width, relatedBy: .equal, toItem: yellowView, attribute: .width, multiplier: 1, constant: 0).isActive = true // 等宽
        
        // 打印所有约束
        for constraint in self.view.constraints {
            print(constraint)
        }
        
    }
    
}
