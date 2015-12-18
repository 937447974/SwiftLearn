//
//  YJAutoLayoutAnchorVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/18.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// NSLayoutAnchor 是IOS9推出的，优化NSLayoutConstraint
class YJAutoLayoutAnchorVC: UIViewController {
    
    /*
    NSLayoutAnchor，如constraintEqualToAnchor(anchor: NSLayoutAnchor!)
    遵循的原则，在UI上，
    1. 左边的View对应self，右边的View对应anchor；
    2. 下面的View对应self，上面的View对应anchor。
    结论就是：从右下到左上
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1 添加View
        // 黄View
        let yellowView = UIView()
        yellowView.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(yellowView)
        // 绿View
        let greenView = UIView()
        greenView.backgroundColor = UIColor.greenColor()
        self.view.addSubview(greenView)
        
        // 2 开启AutoLayout
        yellowView.translatesAutoresizingMaskIntoConstraints  = false;
        greenView.translatesAutoresizingMaskIntoConstraints = false;
        
        // 3 设置约束
        /* 约束伪代码
        Yellow View.Leading = Superview.Leading + 20.0
        Yellow View.Top = Top Layout Guide.Bottom + 20.0
        Bottom Layout Guide.Top = Yellow View.Bottom + 20.0
        
        Green View.Trailing = Superview.Trailing + 20.0
        Green View.Top = Top Layout Guide.Bottom + 20.0
        Bottom Layout Guide.Top = Green View.Bottom + 20.0
        
        Green View.Leading = Yellow View.Trailing + 30.0
        Yellow View.Width = Green View.Width
        */
        // 3.1 yellow约束
        yellowView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 20).active = true
        yellowView.topAnchor.constraintEqualToAnchor(self.topLayoutGuide.bottomAnchor, constant: 20).active = true
        self.bottomLayoutGuide.topAnchor.constraintEqualToAnchor(yellowView.bottomAnchor, constant: 20).active = true
        
        // 3.2 green约束
        greenView.topAnchor.constraintEqualToAnchor(self.topLayoutGuide.bottomAnchor, constant: 20).active = true
        self.view.trailingAnchor.constraintEqualToAnchor(greenView.trailingAnchor, constant: 20).active = true
        self.bottomLayoutGuide.topAnchor.constraintEqualToAnchor(greenView.bottomAnchor, constant: 20).active = true
        
        // 3.3 green和yellow的共有约束
        greenView.leadingAnchor.constraintEqualToAnchor(yellowView.trailingAnchor, constant: 30).active = true // 间距
        greenView.widthAnchor.constraintEqualToAnchor(yellowView.widthAnchor, constant: 20).active = true // 等宽
        
        // 打印所有约束
        for constraint in self.view.constraints {
            //            print(constraint)
        }
    }
    
}
