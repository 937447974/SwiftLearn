//
//  YJCollectionViewFlowLayout.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/22.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// 自定义UICollectionViewDelegateFlowLayout
@objc public protocol YJCollectionViewDelegateFlowLayout: UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// 获取cell高度
    ///
    /// - parameter collectionView: UICollectionView
    /// - parameter collectionViewFlowLayout: YJCollectionViewFlowLayout
    /// - parameter indexPath: NSIndexPath
    ///
    /// - returns: CGFloat
    func collectionView(_ collectionView: UICollectionView, layout collectionViewFlowLayout: YJCollectionViewFlowLayout, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
    
    /// 获取列宽
    ///
    /// - parameter collectionView: UICollectionView
    /// - parameter collectionViewFlowLayout: YJCollectionViewFlowLayout
    /// - parameter column: 列
    ///
    /// - returns: CGFloat
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewFlowLayout: YJCollectionViewFlowLayout, widthForSectionAtColumn column: Int) -> CGFloat
    
}

/// 自定义UICollectionViewFlowLayout
open class YJCollectionViewFlowLayout : UICollectionViewLayout{
    
    // MARK: - 默认internal属性
    /// header高度
    var headerReferenceHeight: CGFloat = 0.0
    /// footer高度
    var footerReferenceHeight: CGFloat = 0.0
    /// section距边
    var sectionInset: UIEdgeInsets = UIEdgeInsets()
    /// 每列item的宽
    var columnItemWidths = [CGFloat]()
    /// section中的小块
    var sectionItems = [[Int]]() {
        didSet {
            var count = 0
            for list in sectionItems {
                count += list.count
            }
            self.sectionItemsCount = count
            self.invalidateLayout() // 更新布局
        }
    }
    // MARK: - private属性
    /// section中的小块个数,{get}
    var sectionItemsCount = 0
    /// 行间隔
    fileprivate var lineSpacing: CGFloat = 0.0
    /// 列间隔
    fileprivate var interitemSpacing: CGFloat = 0.0
    /// YJCollectionViewDelegateFlowLayout协议
    fileprivate weak var delegateFlowLayout : YJCollectionViewDelegateFlowLayout?{
        get{
            return self.collectionView?.delegate as? YJCollectionViewDelegateFlowLayout
        }
    }
    /// 显示所需高度
    fileprivate var flowHeight: CGFloat = 0.0
    /// 所有的UICollectionViewLayoutAttributes
    fileprivate var allItemAttributes = [UICollectionViewLayoutAttributes]()
    /// Header的UICollectionViewLayoutAttributes
    fileprivate var headersAttributes = [UICollectionViewLayoutAttributes]()
    /// SectionItem的UICollectionViewLayoutAttributes
    fileprivate var sectionItemAttributes = [[UICollectionViewLayoutAttributes]]()
    /// Footer的UICollectionViewLayoutAttributes
    fileprivate var footersAttributes = [UICollectionViewLayoutAttributes]()
    
    // MARK: - Getting the Collection View Information
    // MARK: 返回集合视图的高度和宽度
    override open var collectionViewContentSize : CGSize{
        var contentSize = self.collectionView!.bounds.size
        contentSize.height = self.flowHeight
        return contentSize
    }
    
    // MARK: - Invalidating the Layout
    // MARK: 是否需要布局更新
    override open func shouldInvalidateLayout (forBoundsChange newBounds : CGRect) -> Bool {
        let oldBounds = self.collectionView!.bounds
        if newBounds.width != oldBounds.width{
            return true
        }
        return false
    }
    
    // MARK: - Providing Layout Attributes
    // MARK: 返回指定矩形中所有单元格和视图的布局属性
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var beginIndex = 0
        var endIndex = self.allItemAttributes.count
        var beginIntersects = false
        var endIntersects = false
        // 寻找显示区域坐标
        for var index in 0..<endIndex {
            // 首个index
            if !beginIntersects && rect.intersects(self.allItemAttributes[index].frame) {
                beginIntersects = true
                beginIndex = index;
            }
            // 尾部id
            index = endIndex - 1 - index
            if !endIntersects && rect.intersects(self.allItemAttributes[index].frame){
                endIntersects = true
                endIndex = index+1
                break
            }
            // 都找到提前结束for循环
            if beginIntersects && endIntersects {
                break
            }
        }
        // 数据组装
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for index in beginIndex..<endIndex {
            let attr = self.allItemAttributes[index]
            if rect.intersects(attr.frame) {
                layoutAttributes.append(attr)
            }
        }
        return layoutAttributes
    }
    
    // MARK: 返回指定索引路径中项目的布局属性
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard self.sectionItemAttributes.count > indexPath.section else {
            print("error: NSIndexPath.section, Array index out of range")
            return nil
        }
        guard self.sectionItemAttributes[indexPath.section].count > indexPath.item else {
            print("error: NSIndexPath.item, Array index out of range")
            return nil
        }
        return self.sectionItemAttributes[indexPath.section][indexPath.row]
    }
    
    // MARK: 返回指定的装饰视图的布局属性
    open override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        switch elementKind {
        case UICollectionElementKindSectionHeader:
            return self.headersAttributes[indexPath.section]
        case UICollectionElementKindSectionFooter:
            return self.footersAttributes[indexPath.section]
        default:
            return nil
        }
    }
    
    // MARK: 返回指定的附加视图的布局属性
    override open func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        switch elementKind {
        case UICollectionElementKindSectionHeader:
            return self.headersAttributes[indexPath.section]
        case UICollectionElementKindSectionFooter:
            return self.footersAttributes[indexPath.section]
        default:
            return nil
        }
    }
    
    // MARK: - 更新布局
    override open func prepare(){
        super.prepare()
        /*
        * 1 相关数据清空
        */
        self.allItemAttributes.removeAll()
        self.headersAttributes.removeAll()
        self.footersAttributes.removeAll()
        self.sectionItemAttributes.removeAll()
        self.flowHeight = 0.0
        /*
        * 2 数据校验及准备工作
        */
        guard self.prepareLayoutGuard() else {
            return
        }
        /*
        *  3 加载显示用的UICollectionViewLayoutAttributes
        */
        for section in 0..<self.collectionView!.numberOfSections {
            // 3.1 Section header
            self.prepareLayoutSectionHeader(section)
            // 3.2 Section items
            self.prepareLayoutSectionCell(section)
            // 3.3 Section footer
            self.prepareLayoutSectionFooter(section)
        }
    }
    
    // MARK: 更新布局时的数据校验
    fileprivate func prepareLayoutGuard() -> Bool {
        // 1 collectionView界面view
        guard self.collectionView != nil else {
            print("error: collectionView不存在")
            return false
        }
        // 2 delegateFlowLayout代理实现
        guard self.delegateFlowLayout != nil else {
            print("error: YJCollectionViewDelegateFlowLayout未实现")
            return false
        }
        // 3 numberOfSections有数据
        guard self.collectionView!.numberOfSections != 0 else {
            print("error: numberOfSections = 0")
            return false
        }
        /*
        * 4 列宽处理
        */
        if var columnWidth = self.delegateFlowLayout?.collectionView?(self.collectionView!, layout: self, widthForSectionAtColumn: 0) {
            // 判断是否需要处理列宽
            self.columnItemWidths.removeAll()
            self.columnItemWidths.append(columnWidth)
            for i in 1..<self.sectionItems.count {
                columnWidth = self.delegateFlowLayout!.collectionView!(self.collectionView!, layout: self, widthForSectionAtColumn: i)
                self.columnItemWidths.append(columnWidth)
            }
        }
        guard self.columnItemWidths.count != 0 else { // 无列宽
            print("error: 列宽columnWidths未设置")
            return false
        }
        /*
        * 5 行列间隔
        */
        // 行已占用列宽
        var columnItemWidth: CGFloat = 0
        for itemWidth in self.columnItemWidths {
            columnItemWidth += itemWidth
        }
        // 相同行之间的间隔
        self.interitemSpacing = (self.collectionView!.bounds.size.width - self.sectionInset.left - self.sectionInset.right - columnItemWidth) / CGFloat(self.columnItemWidths.count-1)
        // 不同行之间的间隔和相同行之间的间隔一样，界面美观
        self.lineSpacing = self.interitemSpacing
        return true
    }
    
    // MARK: 更新header布局
    fileprivate func prepareLayoutSectionHeader(_ section: Int) {
        if self.headerReferenceHeight > 0 {
            let indexPath = IndexPath(row: 0, section: section)
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: indexPath)
            attributes.frame.origin.y = self.flowHeight
            attributes.frame.size.height = self.headerReferenceHeight
            attributes.frame.size.width = self.collectionView!.bounds.size.width
            // 添加到数据源
            self.headersAttributes.append(attributes)
            self.allItemAttributes.append(attributes)
            self.flowHeight = attributes.frame.maxY
        }
    }
    
    // MARK: 更新cell布局
    fileprivate func prepareLayoutSectionCell(_ section: Int) {
        self.flowHeight += self.sectionInset.top // 调整显示高
        // 块拆分
        let numberOfItemsInSection = self.collectionView!.numberOfItems(inSection: section)
        var numberOfSectionItems = numberOfItemsInSection / self.sectionItemsCount
        if self.collectionView!.numberOfItems(inSection: section) % self.sectionItemsCount != 0 {
            numberOfSectionItems += 1
        }
        var sectionItemAttribute = [UICollectionViewLayoutAttributes]() // section中的Attribute
        var sectionItemsRect = CGRect.zero // section中的item显示区域
        var attributes = UICollectionViewLayoutAttributes() // 添加的LayoutAttributes
        for numberOfSectionItem in 0..<numberOfSectionItems {
            var sectionItemsLeft = self.sectionInset.left // sectionItem的left
            for (indexSectionItem, sectionItem) in self.sectionItems.enumerated() {
                var sectionItemsTop = self.flowHeight // sectionItem的top
                // 处理小列
                for var item in sectionItem {
                    item = self.sectionItemsCount * numberOfSectionItem + item
                    guard item < numberOfItemsInSection else { // 安全处理
                        break
                    }
                    let indexPath = IndexPath(item: item, section: section)
                    // 组装UICollectionViewLayoutAttributes
                    attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    attributes.frame.origin.x = sectionItemsLeft
                    attributes.frame.origin.y = sectionItemsTop
                    attributes.frame.size.height = self.delegateFlowLayout!.collectionView(self.collectionView!, layout: self, heightForItemAtIndexPath: indexPath)
                    attributes.frame.size.width = self.columnItemWidths[indexSectionItem]
                    sectionItemAttribute.append(attributes) // 添加到临时数据源
                    sectionItemsTop = attributes.frame.maxY + self.lineSpacing // 移动top
                    sectionItemsRect = sectionItemsRect.union(attributes.frame) // 扩大section中的item显示区域
                }
                sectionItemsLeft = attributes.frame.maxX + self.interitemSpacing // 移动left
            }
            self.flowHeight = sectionItemsRect.maxY + self.lineSpacing // 移动高度显示
        }
        // 添加到数据源
        self.sectionItemAttributes.append(sectionItemAttribute)
        self.allItemAttributes.append(contentsOf: sectionItemAttribute)
        self.flowHeight = self.flowHeight - self.lineSpacing + self.sectionInset.bottom // 移动高度显示
    }
    
    // MARK: 更新footer布局
    fileprivate func prepareLayoutSectionFooter(_ section: Int) {
        if self.footerReferenceHeight > 0 {
            let indexPath = IndexPath(row: 0, section: section)
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, with: indexPath)
            attributes.frame.origin.y = self.flowHeight
            attributes.frame.size.height = self.footerReferenceHeight
            attributes.frame.size.width = self.collectionView!.bounds.size.width
            // 添加到数据源
            self.footersAttributes.append(attributes)
            self.allItemAttributes.append(attributes)
            self.flowHeight = attributes.frame.maxY
        }
    }
    
}
