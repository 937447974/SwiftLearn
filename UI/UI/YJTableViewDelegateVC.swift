//
//  YJTableViewDelegateVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/14.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// 打印测试
private enum YJPrintStyle: Int {
    case configuringRowsForTheTableView
    case managingAccessoryViews
    case managingSelections
    case modifyingTheHeaderAndFooterOfSections
    case editingTableRows
    case reorderingTableRows
    case trackingTheRemovalOfViews
    case copyingAndPastingRowContent
    case managingTableViewHighlighting
    case managingTableViewFocus
    
}

/// UITableViewDelegate演示
class YJTableViewDelegateVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /// 数据源
    var data = [[Int]]()
    /// UITableView
    @IBOutlet weak var tableView: UITableView!
    /// 打印测试
    fileprivate var printStyle: YJPrintStyle!
    
    // MARK: - view
    override func viewDidLoad() {
        super.viewDidLoad()
        self.printStyle = .managingTableViewFocus
        // 以组演示,填充相关测试数据
        var section = [Int]()
        for _ in 0..<5 {
            section.removeAll()
            for row in 0..<10 {
                section.append(row)
            }
            self.data.append(section)
        }
        // self.tableView.editing = true
    }
    
    // MARK: - UITableViewDataSource
    // MARK: 有几组
    func numberOfSections(in tableView: UITableView) -> Int  {
        return self.data.count
    }
    
    // MARK: 每一组有几个元素
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    // MARK: 生成Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
            cell?.accessoryType = UITableViewCellAccessoryType.detailButton
        }
        cell?.textLabel?.text = "\(self.data[indexPath.section][indexPath.row])--\(indexPath.section)"
        if self.printStyle == .managingTableViewFocus {
            cell?.focusStyle = UITableViewCellFocusStyle.custom // 自定义焦点
        }
        return cell!
    }
    
    // MARK: 索引
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var sectionTitles = [String]()
        for i in 0..<self.data.count {
            sectionTitles.append("\(i)")
        }
        return sectionTitles
    }
    
    // MARK: 索引对应的组
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return Int(title) ?? 0
    }
    
    // MARK: - UITableViewDelegate
    // MARK: - 1. Configuring Rows for the Table View
    // MARK: 预获取行高
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        // 实现此方法后,显示界面前func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloath不会执行，有助于提升显示效率
        if self.printStyle == .configuringRowsForTheTableView {
            print("\(#function)--\(indexPath)")
        }
        return tableView.estimatedRowHeight
    }
    
    // MARK: 行缩进
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if self.printStyle == .configuringRowsForTheTableView {
            print("\(#function)--\(indexPath)")
        }
        return self.data[indexPath.section][indexPath.row]
    }
    
    // MARK: 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.printStyle == .configuringRowsForTheTableView {
            print("\(#function)--\(indexPath)")
        }
        // 默认44
        return tableView.rowHeight
    }
    
    // MARK: 将要显示行
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.printStyle == .configuringRowsForTheTableView {
            print("\(#function)--\(indexPath)")
        }
    }
    
    // MARK: - 2. Managing Accessory Views
    // MARK: 左滑出现的按钮
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if self.printStyle == .managingAccessoryViews {
            print("\(#function)--\(indexPath)")
        }
        var action = [UITableViewRowAction]()
        let handler: (UITableViewRowAction, IndexPath) -> Void = {(action: UITableViewRowAction, indexPath: IndexPath) in
            print("\(indexPath)--\(String(describing: action.title))")
        }
        action.append(UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Default", handler:handler))
        action.append(UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Destructive", handler:handler))
        action.append(UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Normal", handler:handler))
        return action
    }
    
    // MARK: 点击cell上的系统按钮
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // cell?.accessoryType = UITableViewCellAccessoryType.DetailButton
        if self.printStyle == .managingAccessoryViews {
            print("\(#function)--\(indexPath)")
        }
    }
    
    // MARK: - 3. Managing Selections
    // MARK: 将要点击某行
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if self.printStyle == .managingSelections {
            print("\(#function)--\(indexPath)")
        }
        // 返回nil代表不能点击
        return indexPath
    }
    
    // MARK: 点击某行
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.printStyle == .managingSelections {
            print("\(#function)--\(indexPath)")
        }
    }
    
    // MARK: 将要删除某行
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        if self.printStyle == .managingSelections {
            print("\(#function)--\(indexPath)")
        }
        // 返回nil代表不能删除
        return indexPath
    }
    
    // MARK: 删除某行
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if self.printStyle == .managingSelections {
            print("\(#function)--\(indexPath)")
        }
    }
    
    // MARK: - 4. Modifying the Header and Footer of Sections
    // MARK: 预获取header高
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if self.printStyle == .modifyingTheHeaderAndFooterOfSections {
            print("\(#function)--\(section)")
        }
        return tableView.estimatedSectionHeaderHeight
    }
    
    // MARK: 预获取footer高
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        if self.printStyle == .modifyingTheHeaderAndFooterOfSections {
            print("\(#function)--\(section)")
        }
        return tableView.estimatedSectionFooterHeight
    }
    
    // MARK: header高
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.printStyle == .modifyingTheHeaderAndFooterOfSections {
            print("\(#function)--\(section)")
        }
        return tableView.sectionHeaderHeight
    }
    
    // MARK: footer高
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.printStyle == .modifyingTheHeaderAndFooterOfSections {
            print("\(#function)--\(section)")
        }
        return tableView.sectionFooterHeight
    }
    
    // MARK: 自定义header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.printStyle == .modifyingTheHeaderAndFooterOfSections {
            print("\(#function)--\(section)")
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: YJUtilScreenSize.screenWidth, height: tableView.sectionHeaderHeight))
        view.backgroundColor = UIColor.red
        return view
    }
    
    // MARK: 自定义footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if self.printStyle == .modifyingTheHeaderAndFooterOfSections {
            print("\(#function)--\(section)")
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: YJUtilScreenSize.screenWidth, height: tableView.sectionFooterHeight))
        view.backgroundColor = UIColor.yellow
        return view
    }
    
    // MARK: 将要显示header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if self.printStyle == .modifyingTheHeaderAndFooterOfSections {
            print("\(#function)--\(section)")
        }
    }
    
    // MARK: 将要显示footer
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if self.printStyle == .modifyingTheHeaderAndFooterOfSections {
            print("\(#function)--\(section)")
        }
    }
    
    // MARK: - 5. Editing Table Rows
    // MARK: 将要进入编辑模式
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        if self.printStyle == .editingTableRows {
            print("\(#function)--\(indexPath)")
        }
    }
    
    // MARK: 退出编辑模式
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        if self.printStyle == .editingTableRows {
            print("\(#function)--\(String(describing: indexPath))")
        }
    }
    
    // MARK: 编辑模式执行的操作
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if self.printStyle == .editingTableRows {
            print("\(#function)--\(indexPath)")
        }
        return UITableViewCellEditingStyle.delete
    }
    
    // MARK: 更改默认的删除按钮标题
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        if self.printStyle == .editingTableRows {
            print("\(#function)--\(indexPath)")
        }
        return "自定义"
    }
    
    // MARK: 编辑模式下表视图背景是否缩进
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        if self.printStyle == .editingTableRows {
            print("\(#function)--\(indexPath)")
        }
        return true
    }
    
    // MARK: - 6. Reordering Table Rows
    // MARK: 移动cell
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if self.printStyle == .reorderingTableRows {
            print("\(#function)--\(sourceIndexPath)--\(proposedDestinationIndexPath)")
        }
        return proposedDestinationIndexPath
    }
    
    // MARK: - 7. Tracking the Removal of Views
    // MARK: header消失
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if self.printStyle == .trackingTheRemovalOfViews {
            print("\(#function)--\(section)")
        }
    }
    
    // MARK: cell消失
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.printStyle == .trackingTheRemovalOfViews {
            print("\(#function)--\(indexPath)")
        }
    }
    
    // MARK: footer消失
    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        if self.printStyle == .trackingTheRemovalOfViews {
            print("\(#function)--\(section)")
        }
    }
    
    // MARK: - 8. Copying and Pasting Row Content
    // 将要显示复制和粘贴板
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        if self.printStyle == .copyingAndPastingRowContent {
            print("\(#function)--\(indexPath)")
        }
        return true
    }
    
    // 显示复制和粘贴板
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        if self.printStyle == .copyingAndPastingRowContent {
            print("\(#function)--\(indexPath)")
        }
        return true
    }
    
    // MARK: 点击复制和粘贴板上的按钮
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        if self.printStyle == .copyingAndPastingRowContent {
            print("\(#function)--\(indexPath)--\(action)--\(String(describing: sender))")
        }
    }
    
    // MARK: - 9. Managing Table View Highlighting
    // MARK: 点击cell能否进入高亮模式
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if self.printStyle == .managingTableViewHighlighting {
            print("\(#function)--\(indexPath)")
        }
        return true
    }
    
    // MARK: 正式进入高亮模式
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if self.printStyle == .managingTableViewHighlighting {
            print("\(#function)--\(indexPath)")
        }
    }
    
    // MARK: 离开高亮模式
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if self.printStyle == .managingTableViewHighlighting {
            print("\(#function)--\(indexPath)")
        }
    }
    
    // MARK: - 10. Managing Table View Focus
    // MARK: 是否指定路径
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        if self.printStyle == .managingTableViewFocus {
            print("\(#function)--\(indexPath)")
        }
        return true
    }
    
    // MARK: 是否允许上下文更新
    func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        if self.printStyle == .managingTableViewFocus {
            print("\(#function)--\(context)")
        }
        return true
    }
    
    // MARK: 上下文更新结束
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if self.printStyle == .managingTableViewFocus {
            print("\(#function)--\(context)")
        }
    }
    
    // MARK: 索引对应的路径
    func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath? {
        if self.printStyle == .managingTableViewFocus {
            print("\(#function)")
        }
        return nil
    }
    
}
