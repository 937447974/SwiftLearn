//
//  YJTableViewCellTVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/15.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// 样式
private enum YJCellStyle : Int {
    
    case Style
    case SelectionStyle
    case AccessoryType
    case SeparatorStyle
    case ManagingContentIndentation
    case SwitchTableViewCell
    
    /// 获取标题
    func title() -> String {
        var title = ""
        switch self {
        case .Style, .SelectionStyle, .AccessoryType, .SeparatorStyle:
            title = "UITableViewCell\(self)"
        case .ManagingContentIndentation:
            title = "缩进"
        case .SwitchTableViewCell:
            title = "有开关的cell"
        }
        return title
    }
    
    init(title: String) {
        switch title {
        case YJCellStyle.SelectionStyle.title():
            self = YJCellStyle.SelectionStyle
        case YJCellStyle.AccessoryType.title():
            self = YJCellStyle.AccessoryType
        case YJCellStyle.ManagingContentIndentation.title():
            self = YJCellStyle.ManagingContentIndentation
        case YJCellStyle.SwitchTableViewCell.title():
            self = YJCellStyle.SwitchTableViewCell
        default:
            self = YJCellStyle.Style
        }
    }
    
}

/// UITableViewCell
class YJTableViewCellTVC: UITableViewController {
    
    // 显示样式
    private var cellStyle = YJCellStyle.Style
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "YJSwitchTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "YJSwitchTableViewCell")
    }
    
    // MARK: - 开起和关闭tableView编辑状态
    @IBAction func onClickEdit(sender: AnyObject) {
        self.tableView.setEditing(!self.tableView.editing, animated: true)
    }
    
    // MARK: 样式展示
    @IBAction func onClickSearch(sender: AnyObject) {
        let handler: ((UIAlertAction) -> Void) = { (action: UIAlertAction) -> Void in
            self.cellStyle = YJCellStyle(title: action.title!)
            self.tableView.reloadData()
        }
        let alertController = UIAlertController(title: "样式展示", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        alertController.addAction(UIAlertAction(title: YJCellStyle.Style.title(), style: .Default, handler: handler))
        alertController.addAction(UIAlertAction(title: YJCellStyle.SelectionStyle.title(), style: .Default, handler: handler))
        alertController.addAction(UIAlertAction(title: YJCellStyle.AccessoryType.title(), style: .Default, handler: handler))
        alertController.addAction(UIAlertAction(title: YJCellStyle.SeparatorStyle.title(), style: .Default, handler: { (action: UIAlertAction) -> Void in
            self.tableViewCellWithSeparatorStyle()
        }))
        alertController.addAction(UIAlertAction(title: YJCellStyle.ManagingContentIndentation.title(), style: .Default, handler: handler))
        alertController.addAction(UIAlertAction(title: YJCellStyle.SwitchTableViewCell.title(), style: .Default, handler: handler))
        alertController.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: 4. UITableViewCellSeparatorStyle
    func tableViewCellWithSeparatorStyle() {
        /*
        public enum UITableViewCellSeparatorStyle : Int {
        case None
        case SingleLine
        case SingleLineEtched // This separator style is only supported for grouped style table views currently
        }
        */
        
        let alertController = UIAlertController(title: "UITableViewCellSeparatorStyle", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        alertController.addAction(UIAlertAction(title: "None", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }))
        alertController.addAction(UIAlertAction(title: "SingleLine", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            self.tableView.separatorColor = UIColor.redColor() // 可修改线条颜色
        }))
        alertController.addAction(UIAlertAction(title: "SingleLineEtched", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLineEtched
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        switch self.cellStyle {
        case YJCellStyle.Style, YJCellStyle.SelectionStyle, YJCellStyle.SwitchTableViewCell:
            row = 4
        case YJCellStyle.AccessoryType, YJCellStyle.ManagingContentIndentation:
            row = 5
        default:
            row = 0
        }
        return row
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch self.cellStyle {
        case YJCellStyle.SelectionStyle:
            return self.tableViewCellWithSelectionStyle(tableView, cellForRowAtIndexPath: indexPath)
        case YJCellStyle.AccessoryType:
            return self.tableViewCellWithAccessoryType(tableView, cellForRowAtIndexPath: indexPath)
        case YJCellStyle.ManagingContentIndentation:
            return self.tableViewCellWithManagingContentIndentation(tableView, cellForRowAtIndexPath: indexPath)
        case YJCellStyle.SwitchTableViewCell:
            return self.tableViewCellWithSwitch(tableView, cellForRowAtIndexPath: indexPath)
        default:
            self.tableViewCellWithStyle(tableView, cellForRowAtIndexPath: indexPath)
        }
        return self.tableViewCellWithStyle(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    // MARK: - 1. UITableViewCellStyle
    func tableViewCellWithStyle(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        switch indexPath.row {
        case 0:
            cell  = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
            cell.textLabel?.text = "Default" // 标题
        case 1:
            cell  = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
            cell.textLabel?.text = "Value1" // 标题
        case 2:
            cell  = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
            cell.textLabel?.text = "Value2" // 标题
        default:
            cell  = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
            cell.textLabel?.text = "Subtitle" // 标题
        }
        cell.imageView?.image = UIImage(named: "qq") // 图片
        cell.detailTextLabel?.text = "UITableViewCellStyle" // 描述
        return cell
    }
    
    // MARK: 2. UITableViewCellSelectionStyle
    func tableViewCellWithSelectionStyle(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!  = tableView.dequeueReusableCellWithIdentifier("SelectionStyle")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "SelectionStyle")
        }
        switch indexPath.row {
        case 0:
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.textLabel?.text = "None"
        case 1:
            cell.selectionStyle = UITableViewCellSelectionStyle.Blue
            cell.textLabel?.text = "Blue"
        case 2:
            cell.selectionStyle = UITableViewCellSelectionStyle.Gray
            cell.textLabel?.text = "Gray"
        default:
            cell.selectionStyle = UITableViewCellSelectionStyle.Default
            cell.textLabel?.text = "Default"
        }
        return cell!
    }
    
    // MARK: 3 UITableViewCellAccessoryType
    func tableViewCellWithAccessoryType(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!  = tableView.dequeueReusableCellWithIdentifier("AccessoryType")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "AccessoryType")
        }
        switch indexPath.row {
        case 0:
            cell.accessoryType = UITableViewCellAccessoryType.None // 右变的小图标
            cell.textLabel?.text = "None"
        case 1:
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.textLabel?.text = "DisclosureIndicator"
        case 2:
            cell.accessoryType = UITableViewCellAccessoryType.DetailDisclosureButton
            cell.textLabel?.text = "DetailDisclosureButton"
        case 3:
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell.textLabel?.text = "Checkmark"
        default:
            cell.accessoryType = UITableViewCellAccessoryType.DetailButton
            cell.textLabel?.text = "DetailButton"
        }
        cell.editingAccessoryType = cell.accessoryType // 编辑模式下的小图标，默认.None
        return cell!
    }
    
    // MARK: 5 Managing Content Indentation
    func tableViewCellWithManagingContentIndentation(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!  = tableView.dequeueReusableCellWithIdentifier("MCIndentation")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MCIndentation")
        }
        cell.textLabel?.text = "\(indexPath.section)--\(indexPath.row)"
        cell.indentationLevel = indexPath.row // 缩进的级别
        cell.indentationWidth = 10.0 * CGFloat(indexPath.section+1) // 缩进的基数,默认10.0
        cell.shouldIndentWhileEditing = false // 编辑模式是否缩进，默认true
        return cell!
    }
    
    // MARK: 6 带switch样式的cell
    func tableViewCellWithSwitch(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 注册的cell可直接提取
        let cell = tableView.dequeueReusableCellWithIdentifier("YJSwitchTableViewCell") as! YJSwitchTableViewCell
        cell.titleLabel.text = "\(indexPath.section)--\(indexPath.row)"
        cell.indexPath = indexPath
        // 监听
        cell.handler = { (cell: YJSwitchTableViewCell) -> Void in
            print("\(cell.yjSwitch.on):\(indexPath.section)--\(indexPath.row)")
        }
        return cell
    }
    
}
