//
//  YJScrollViewDelegateVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/17.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// UIScrollViewDelegate
class YJScrollViewDelegateVC: UIViewController, UIScrollViewDelegate {
    
    /// 照片
    var imageView: UIImageView!
    /// UIScrollView
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "纯代码"
        
        let scrollItem = UIBarButtonItem(title: "Scroll", style: .plain, target: self, action: #selector(YJScrollViewDelegateVC.onClickScroll))
        let zoomItem = UIBarButtonItem(title: "Zoom", style: .plain, target: self, action: #selector(YJScrollViewDelegateVC.onClickZoom))
        self.navigationItem.rightBarButtonItems = [scrollItem, zoomItem]
        
        // 填充UIScrollView
        self.scrollView = UIScrollView(frame: self.view.frame)
        self.view.addSubview(self.scrollView)
        self.scrollView.delegate = self
        // 图片
        let image = UIImage(named: "ScrollViewBigImage")
        self.imageView = UIImageView(image: image)
        self.scrollView.addSubview(self.imageView)
        self.scrollView.contentSize = image!.size // 可移动区域
        
        // 缩放
        self.scrollView.minimumZoomScale = 0.5
        self.scrollView.maximumZoomScale = 2
        
        // 其他相关属性
        print("bounces:\(self.scrollView.bounces)") // 全局滚动阻力,默认true
        print("alwaysBounceVertical:\(self.scrollView.alwaysBounceVertical)") // y轴滚动阻力,默认true
        print("alwaysBounceHorizontal:\(self.scrollView.alwaysBounceHorizontal)") // x轴滚动阻力,默认false
        print("bouncesZoom:\(self.scrollView.bouncesZoom)") // 缩放阻力,默认true
        print("pagingEnabled:\(self.scrollView.isPagingEnabled)") // 已翻页的方式滚动,默认false
        print("scrollEnabled:\(self.scrollView.isScrollEnabled)") // 是否开启滚动,默认true
        print("showsHorizontalScrollIndicator:\(self.scrollView.showsHorizontalScrollIndicator)") // x轴滚动条,默认true
        print("showsVerticalScrollIndicator:\(self.scrollView.showsVerticalScrollIndicator)") // y轴滚动条,默认true
        print("indicatorStyle:\(self.scrollView.indicatorStyle)") // 滚动条样式,默认Default
    }
    
    // MARK: - Action
    // MARK: 移动
    func onClickScroll() {
        print(#function)
        var point = self.scrollView.contentOffset // 当前点
        point.x += 100 // 向左移动100
        point.x = point.x >= self.scrollView.contentSize.width ? 0 : point.x
        self.scrollView.setContentOffset(point, animated: true)// 动画移动
    }
    
    // MARK: 缩放
    func onClickZoom() {
        print(#function)
        var zoomScale = self.scrollView.zoomScale // 当前缩放
        zoomScale += 0.5
        if zoomScale >= self.scrollView.maximumZoomScale {
            zoomScale = self.scrollView.minimumZoomScale
        }
        self.scrollView.setZoomScale(zoomScale, animated: true) // 动画缩放
    }
    
    // MARK: - UIScrollViewDelegate
    // MARK: - 滚动持续中
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(#function)
    }
    
    // MARK: - 手指触摸开始滚动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print(#function)
    }
    
    // MARK: 手指离开屏幕后，移动速度
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // velocity:移动速度
        print(#function)
        print("velocity:\(velocity)")
    }
    
    // MARK: 手指离开屏幕后，是否有减速动画
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // decelerate：turu执行减速动画，false直接移动到目标位置
        print(#function)
        print("decelerate:\(decelerate)")
    }
    
    // MARK: 手指离开屏幕后，滚动视图滚动开始减速动画
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print(#function)
        print("decelerationRate:\(scrollView.decelerationRate)")
        scrollView.decelerationRate = scrollView.decelerationRate/2 // 动态设置减速动画速率降低一半
    }
    
    // MARK: 手指移动引起的滚动动画结束
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(#function)
    }
    
    // MARK: 使用setContentOffset/scrollRectVisible:animated:调用的滚动动画结束
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)  {
        print(#function)
    }
    
    // MARK: - 缩放的View
    // MARK: 缩放持续中
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print(#function)
        
    }
    // MARK: 返回要缩放的View
    func viewForZooming(in scrollView: UIScrollView) -> UIView?  {
        print(#function)
        return self.imageView
    }
    
    // MARK: 开始缩放
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        print(#function)
    }
    // MARK: 缩放停止
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print(#function)
        print("scale:\(scale)")
    }
    
    // MARK: - 点击顶部的时间，是否回滚到顶部
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        print(#function)
        // scrollsToTop是否回滚，默认允许回到顶部
        return scrollView.scrollsToTop
    }
    
    // MARK: 回滚到顶部结束
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print(#function)
    }
    
}
