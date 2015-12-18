//
//  YJAutoLayoutSVVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/17.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

class YJAutoLayoutSVVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "纯代码AutoLayout"
        // 创建UIScrollView和UIImageView
        let scrollView  = UIScrollView()
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ScrollViewBigImage")
        
        // 添加视图
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        // 开启AutoLayout
        scrollView.translatesAutoresizingMaskIntoConstraints  = false;
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        
        // self.view和ScrollView的约束
        // 显示区域,方式1添加约束
        let centerXC = NSLayoutConstraint(item: scrollView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0) // 中心x点对齐
        let centerYC = NSLayoutConstraint(item: scrollView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0) // 中心y点对齐
        self.view.addConstraints([centerXC, centerYC]) // 组添加
        let heightC = NSLayoutConstraint(item: scrollView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 1, constant: 0) // 等高
        self.view.addConstraint(heightC) // 单一添加
        NSLayoutConstraint(item: scrollView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1, constant: 0).active = true // 等宽，立即执行
        
        // 滑动区域,方式2添加约束
        // NSLayoutYAxisAnchor封装NSLayoutConstraint写法
        scrollView.topAnchor.constraintEqualToAnchor(imageView.topAnchor).active = true // Top
        scrollView.bottomAnchor.constraintEqualToAnchor(imageView.bottomAnchor).active = true // Bottom
        scrollView.leadingAnchor.constraintEqualToAnchor(imageView.leadingAnchor).active = true // leading
        scrollView.trailingAnchor.constraintEqualToAnchor(imageView.trailingAnchor).active = true // trailing
    }

}
