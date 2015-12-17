//
//  YJAutoLayoutSVVC.swift
//  UI
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
        // 显示区域
        let centerXC = NSLayoutConstraint(item: scrollView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0) // 中心x点对齐
        let centerYC = NSLayoutConstraint(item: scrollView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0) // 中心y点对齐
        let heightC = NSLayoutConstraint(item: scrollView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 1, constant: 0) // 等高
        let widthC = NSLayoutConstraint(item: scrollView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1, constant: 0) // 等宽
        self.view.addConstraints([centerXC, centerYC, heightC, widthC])
        // 滑动区域
        self.view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: imageView, attribute: .Top, multiplier: 1, constant: 0)) // Top
        self.view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: imageView, attribute: .Bottom, multiplier: 1, constant: 0)) //Bottom
        self.view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Leading, relatedBy: .Equal, toItem: imageView, attribute: .Leading, multiplier: 1, constant: 0)) //Leading
        self.view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Trailing, relatedBy: .Equal, toItem: imageView, attribute: .Trailing, multiplier: 1, constant: 0)) //Trailing
    
    }

}
