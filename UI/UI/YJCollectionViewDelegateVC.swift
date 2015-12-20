//
//  YJCollectionViewDelegateVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/19.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// 打印
private enum YJPrint {
    case ManagingTheSelectedCells
    case ManagingCellHighlighting
    case TrackingTheAdditionAndRemovalOfViews
    case HandlingLayoutChanges
    case ManagingActionsForCells
    case ManagingCollectionViewFocus
}

/// UICollectionViewDelegate
class YJCollectionViewDelegateVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    /// UICollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    /// 数据源
    private var data = [[Int]]()
    
    private let yjPrint = YJPrint.HandlingLayoutChanges
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 测试数据
        for _ in 0...2 {
            var list = [Int]()
            for i in 0..<10 {
                list.append(i)
            }
            self.data.append(list)
        }
        // 长点击事件，做移动cell操作
        self.collectionView.allowsMoveItem()
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.data.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.grayColor()
        if let label: UILabel = cell.viewWithTag(8) as? UILabel {
            label.text = "\(indexPath.item)"
        }
        // 设置选中的背景色
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.redColor()
        return cell
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var crView: UICollectionReusableView!
        if (kind == UICollectionElementKindSectionHeader) { // Header
            crView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath)
            crView.backgroundColor = UIColor.greenColor()
            // 标题
            if let label: UILabel = crView.viewWithTag(8) as? UILabel {
                label.text = "\(indexPath.section) Section"
            }
        } else { // Footer
            crView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath)
            crView.backgroundColor = UIColor.blueColor()
        }
        return crView
    }
    
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // 修改数据源
        let temp = self.data[sourceIndexPath.section].removeAtIndex(sourceIndexPath.item)
        self.data[destinationIndexPath.section].insert(temp, atIndex: destinationIndexPath.item)
    }
    
    // MARK: - UICollectionViewDelegate
    // MARK: - Managing the Selected Cells
    // MARK: 是否选中某个item
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if self.yjPrint == YJPrint.ManagingTheSelectedCells {
            print("\(__FUNCTION__)--\(indexPath)")
        }
        return true
    }
    // MARK: 选中某个item
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if self.yjPrint == YJPrint.ManagingTheSelectedCells {
            print("\(__FUNCTION__)--\(indexPath)")
        }
    }
    
    // MARK: 是否取消选中某个item
    func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if self.yjPrint == YJPrint.ManagingTheSelectedCells {
            print("\(__FUNCTION__)--\(indexPath)")
        }
        return true
    }
    
    // MARK: 取消选中
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if self.yjPrint == YJPrint.ManagingTheSelectedCells {
            print("\(__FUNCTION__)--\(indexPath)")
        }
    }
    
    // MARK: - Managing Cell Highlighting
    // MARK: 能否选中高亮
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if self.yjPrint == YJPrint.ManagingCellHighlighting {
            print("\(__FUNCTION__)--\(indexPath)")
        }
        return true
    }
    
    // MARK: 高亮
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        if self.yjPrint == YJPrint.ManagingCellHighlighting {
            print("\(__FUNCTION__)--\(indexPath)")
        }
    }
    
    // MARK: 高亮取消
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        if self.yjPrint == YJPrint.ManagingCellHighlighting {
            print("\(__FUNCTION__)--\(indexPath)")
        }
    }
    
    // MARK: - Tracking the Addition and Removal of Views
    // MARK: cell显示
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if self.yjPrint == YJPrint.TrackingTheAdditionAndRemovalOfViews {
            print("\(__FUNCTION__)--\(indexPath)")
        }
    }
    
    // MARK: cell消失
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if self.yjPrint == YJPrint.TrackingTheAdditionAndRemovalOfViews {
            print("\(__FUNCTION__)--\(indexPath)")
        }
    }
    
    // MARK: Header或Footer显示
    func collectionView(collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: NSIndexPath) {
        if self.yjPrint == YJPrint.TrackingTheAdditionAndRemovalOfViews {
            print("\(__FUNCTION__)--\(indexPath)--\(elementKind)")
        }
    }
    
    // MARK: Header或Footer消失
    func collectionView(collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, atIndexPath indexPath: NSIndexPath) {
        if self.yjPrint == YJPrint.TrackingTheAdditionAndRemovalOfViews {
            print("\(__FUNCTION__)--\(indexPath)--\(elementKind)")
        }
    }
    
    // MARK: - Handling Layout Changes
    // MARK: collectionViewLayout: UICollectionViewLayout发生改变
    func collectionView(collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        if self.yjPrint == YJPrint.HandlingLayoutChanges {
            print("\(__FUNCTION__)")
        }
        return UICollectionViewTransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
    }
    
    // MARK: cell可移动时的起始偏移
    func collectionView(collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        if self.yjPrint == YJPrint.HandlingLayoutChanges {
            print("\(__FUNCTION__)--\(proposedContentOffset)")
        }
        return proposedContentOffset
    }
    
    // MARK: 移动cell从originalIndexPath到proposedIndexPath
    func collectionView(collectionView: UICollectionView, targetIndexPathForMoveFromItemAtIndexPath originalIndexPath: NSIndexPath, toProposedIndexPath proposedIndexPath: NSIndexPath) -> NSIndexPath {
        if self.yjPrint == YJPrint.HandlingLayoutChanges {
            print("\(__FUNCTION__)")
            print("\(originalIndexPath) -> \(proposedIndexPath)")
        }
        return proposedIndexPath
    }
    
    
    
//
//
//    Handling Layout Changes
//    Managing Actions for Cells
//    Managing Collection View Focus
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
