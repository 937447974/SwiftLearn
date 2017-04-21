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
        let centerXC = NSLayoutConstraint(item: scrollView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0) // 中心x点对齐
        let centerYC = NSLayoutConstraint(item: scrollView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0) // 中心y点对齐
        self.view.addConstraints([centerXC, centerYC]) // 组添加
        let heightC = NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0) // 等高
        self.view.addConstraint(heightC) // 单一添加
        NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0).isActive = true // 等宽，立即执行
        
        // 滑动区域,方式2添加约束
        // NSLayoutYAxisAnchor封装NSLayoutConstraint写法
        scrollView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true // Top
        scrollView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true // Bottom
        scrollView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true // leading
        scrollView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true // trailing
    }

}
