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
    case managingTheSelectedCells
    case managingCellHighlighting
    case trackingTheAdditionAndRemovalOfViews
    case handlingLayoutChanges
    case managingActionsForCells
}

/// UICollectionViewDelegate
class YJCollectionViewDelegateVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    /// UICollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    /// 数据源
    fileprivate var data = [[Int]]()
    /// 打印
    fileprivate let yjPrint = YJPrint.managingActionsForCells
    
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
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.gray
        if let label: UILabel = cell.viewWithTag(8) as? UILabel {
            label.text = "\(indexPath.item)"
        }
        // 设置选中的背景色
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var crView: UICollectionReusableView!
        if (kind == UICollectionElementKindSectionHeader) { // Header
            crView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            crView.backgroundColor = UIColor.green
            // 标题
            if let label: UILabel = crView.viewWithTag(8) as? UILabel {
                label.text = "\(indexPath.section) Section"
            }
        } else { // Footer
            crView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
            crView.backgroundColor = UIColor.blue
        }
        return crView
    }
    
    // MARK: - UICollectionViewDelegate
    // MARK: - Managing the Selected Cells
    // MARK: 是否选中某个item
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if self.yjPrint == YJPrint.managingTheSelectedCells {
            print("\(#function)--{\(indexPath.section),\(indexPath.item)}")
        }
        return true
    }
    
    // MARK: 选中某个item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.yjPrint == YJPrint.managingTheSelectedCells {
            print("\(#function)--{\(indexPath.section),\(indexPath.item)}")
        }
    }
    
    // MARK: 是否取消选中某个item
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if self.yjPrint == YJPrint.managingTheSelectedCells {
            print("\(#function)--{\(indexPath.section),\(indexPath.item)}")
        }
        return true
    }
    
    // MARK: 取消选中
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if self.yjPrint == YJPrint.managingTheSelectedCells {
            print("\(#function)--{\(indexPath.section),\(indexPath.item)}")
        }
    }
    
    // MARK: - Managing Cell Highlighting
    // MARK: 能否选中高亮
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        if self.yjPrint == YJPrint.managingCellHighlighting {
            print("\(#function)--{\(indexPath.section),\(indexPath.item)}")
        }
        return true
    }
    
    // MARK: 高亮
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if self.yjPrint == YJPrint.managingCellHighlighting {
            print("\(#function)--{\(indexPath.section),\(indexPath.item)}")
        }
    }
    
    // MARK: 高亮取消
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if self.yjPrint == YJPrint.managingCellHighlighting {
            print("\(#function)--{\(indexPath.section),\(indexPath.item)}")
        }
    }
    
    // MARK: - Tracking the Addition and Removal of Views
    // MARK: cell显示
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.yjPrint == YJPrint.trackingTheAdditionAndRemovalOfViews {
            print("\(#function)--{\(indexPath.section),\(indexPath.item)}")
        }
    }
    
    // MARK: cell消失
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.yjPrint == YJPrint.trackingTheAdditionAndRemovalOfViews {
            print("\(#function)--{\(indexPath.section),\(indexPath.item)}")
        }
    }
    
    // MARK: Header或Footer显示
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if self.yjPrint == YJPrint.trackingTheAdditionAndRemovalOfViews {
            print("\(#function)--\(indexPath)--\(elementKind)")
        }
    }
    
    // MARK: Header或Footer消失
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if self.yjPrint == YJPrint.trackingTheAdditionAndRemovalOfViews {
            print("\(#function)--\(indexPath)--\(elementKind)")
        }
    }
    
    // MARK: - Handling Layout Changes
    // MARK: collectionViewLayout: UICollectionViewLayout发生改变
    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        if self.yjPrint == YJPrint.handlingLayoutChanges {
            print("\(#function)")
        }
        return UICollectionViewTransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
    }
    
    // MARK: cell可移动时的起始偏移
    func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        if self.yjPrint == YJPrint.handlingLayoutChanges {
            print("\(#function)--\(proposedContentOffset)")
        }
        return proposedContentOffset
    }
    
    // MARK: 移动cell从originalIndexPath到proposedIndexPath
    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        if self.yjPrint == YJPrint.handlingLayoutChanges {
            print("\(#function)")
            print("\(originalIndexPath) -> \(proposedIndexPath)")
        }
        return proposedIndexPath
    }
    
    // MARK: - Managing Actions for Cells
    // MARK: 长按，是否将要显示Action菜单（剪切、拷贝、粘贴）
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        if self.yjPrint == YJPrint.managingActionsForCells {
            print("\(#function)--{\(indexPath.section),\(indexPath.item)}")
        }
        return true
    }
    
    // MARK: 长按，是否显示Action菜单（剪切、拷贝、粘贴）
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        if self.yjPrint == YJPrint.managingActionsForCells {
            print("\(#function)--{\(indexPath.section),\(indexPath.item)}--\(String(describing: sender))")
        }
        return true
    }
    
    // MARK: 点击菜单中的某个选项
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        if self.yjPrint == YJPrint.managingActionsForCells {
            print("\(#function)--{\(indexPath.section),\(indexPath.item)}--\(String(describing: sender))")
        }
    }
    
    // MARK: - Managing Collection View Focus，开发中用不到
    /*
    func collectionView(collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: NSIndexPath) -> Bool
    
    func collectionView(collectionView: UICollectionView, shouldUpdateFocusInContext context: UICollectionViewFocusUpdateContext) -> Bool
    
    func collectionView(collectionView: UICollectionView, didUpdateFocusInContext context: UICollectionViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator)
    
    func indexPathForPreferredFocusedViewInCollectionView(collectionView: UICollectionView) -> NSIndexPath?
    */
}
