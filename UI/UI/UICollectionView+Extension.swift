//
//  UICollectionView+Extension.swift
//  UI
//
//  Created by yangjun on 15/12/20.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// UICollectionView扩展
public extension UICollectionView {

    // MARK: - 移动Item
    /// 允许手势移动Item，默认不允许
    ///
    /// - returns: void
    func allowsMoveItem() {
        // 长点击事件，做移动cell操作
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(UICollectionView.handleLongGestureMove(_:)))
        self.addGestureRecognizer(longPressGesture)
    }
    
    // MARK: 长点击事件
    func handleLongGestureMove(_ gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case UIGestureRecognizerState.began:// 开始移动
            let point = gesture.location(in: gesture.view!)
            if let selectedIndexPath = self.indexPathForItem(at: point) {
                self.beginInteractiveMovementForItem(at: selectedIndexPath) // 开始移动
            }
        case UIGestureRecognizerState.changed:
            // 移动中
            let point = gesture.location(in: gesture.view!)
            self.updateInteractiveMovementTargetPosition(point)
        case UIGestureRecognizerState.ended:
            // 结束移动
            self.endInteractiveMovement()
        default:
            // 取消移动
            self.cancelInteractiveMovement()
        }
    }
    
}
