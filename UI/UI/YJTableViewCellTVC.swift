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
    
    case style
    case selectionStyle
    case accessoryType
    case separatorStyle
    case managingContentIndentation
    case switchTableViewCell
    
    /// 获取标题
    func title() -> String {
        var title = ""
        switch self {
        case .style, .selectionStyle, .accessoryType, .separatorStyle:
            title = "UITableViewCell\(self)"
        case .managingContentIndentation:
            title = "缩进"
        case .switchTableViewCell:
            title = "有开关的cell"
        }
        return title
    }
    
    init(title: String) {
        switch title {
        case YJCellStyle.selectionStyle.title():
            self = YJCellStyle.selectionStyle
        case YJCellStyle.accessoryType.title():
            self = YJCellStyle.accessoryType
        case YJCellStyle.managingContentIndentation.title():
            self = YJCellStyle.managingContentIndentation
        case YJCellStyle.switchTableViewCell.title():
            self = YJCellStyle.switchTableViewCell
        default:
            self = YJCellStyle.style
        }
    }
    
}

/// UITableViewCell
class YJTableViewCellTVC: UITableViewController {
    
    // 显示样式
    fileprivate var cellStyle = YJCellStyle.style
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "YJSwitchTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "YJSwitchTableViewCell")
    }
    
    // MARK: - 开起和关闭tableView编辑状态
    @IBAction func onClickEdit(_ sender: AnyObject) {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
    }
    
    // MARK: 样式展示
    @IBAction func onClickSearch(_ sender: AnyObject) {
        let handler: ((UIAlertAction) -> Void) = { (action: UIAlertAction) -> Void in
            self.cellStyle = YJCellStyle(title: action.title!)
            self.tableView.reloadData()
        }
        let alertController = UIAlertController(title: "样式展示", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alertController.addAction(UIAlertAction(title: YJCellStyle.style.title(), style: .default, handler: handler))
        alertController.addAction(UIAlertAction(title: YJCellStyle.selectionStyle.title(), style: .default, handler: handler))
        alertController.addAction(UIAlertAction(title: YJCellStyle.accessoryType.title(), style: .default, handler: handler))
        alertController.addAction(UIAlertAction(title: YJCellStyle.separatorStyle.title(), style: .default, handler: { (action: UIAlertAction) -> Void in
            self.tableViewCellWithSeparatorStyle()
        }))
        alertController.addAction(UIAlertAction(title: YJCellStyle.managingContentIndentation.title(), style: .default, handler: handler))
        alertController.addAction(UIAlertAction(title: YJCellStyle.switchTableViewCell.title(), style: .default, handler: handler))
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
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
        
        let alertController = UIAlertController(title: "UITableViewCellSeparatorStyle", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alertController.addAction(UIAlertAction(title: "None", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction) -> Void in
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        }))
        alertController.addAction(UIAlertAction(title: "SingleLine", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction) -> Void in
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            self.tableView.separatorColor = UIColor.red // 可修改线条颜色
        }))
        alertController.addAction(UIAlertAction(title: "SingleLineEtched", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction) -> Void in
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLineEtched
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        switch self.cellStyle {
        case YJCellStyle.style, YJCellStyle.selectionStyle, YJCellStyle.switchTableViewCell:
            row = 4
        case YJCellStyle.accessoryType, YJCellStyle.managingContentIndentation:
            row = 5
        default:
            row = 0
        }
        return row
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.cellStyle {
        case YJCellStyle.selectionStyle:
            return self.tableViewCellWithSelectionStyle(tableView, cellForRowAtIndexPath: indexPath)
        case YJCellStyle.accessoryType:
            return self.tableViewCellWithAccessoryType(tableView, cellForRowAtIndexPath: indexPath)
        case YJCellStyle.managingContentIndentation:
            return self.tableViewCellWithManagingContentIndentation(tableView, cellForRowAtIndexPath: indexPath)
        case YJCellStyle.switchTableViewCell:
            return self.tableViewCellWithSwitch(tableView, cellForRowAtIndexPath: indexPath)
        default:
            return self.tableViewCellWithStyle(tableView, cellForRowAtIndexPath: indexPath)
        }
    }
    
    // MARK: - 1. UITableViewCellStyle
    func tableViewCellWithStyle(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        switch indexPath.row {
        case 0:
            cell  = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
            cell.textLabel?.text = "Default" // 标题
        case 1:
            cell  = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: nil)
            cell.textLabel?.text = "Value1" // 标题
        case 2:
            cell  = UITableViewCell(style: UITableViewCellStyle.value2, reuseIdentifier: nil)
            cell.textLabel?.text = "Value2" // 标题
        default:
            cell  = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: nil)
            cell.textLabel?.text = "Subtitle" // 标题
        }
        cell.imageView?.image = UIImage(named: "qq") // 图片
        cell.detailTextLabel?.text = "UITableViewCellStyle" // 描述
        return cell
    }
    
    // MARK: 2. UITableViewCellSelectionStyle
    func tableViewCellWithSelectionStyle(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!  = tableView.dequeueReusableCell(withIdentifier: "SelectionStyle")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "SelectionStyle")
        }
        switch indexPath.row {
        case 0:
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.textLabel?.text = "None"
        case 1:
            cell.selectionStyle = UITableViewCellSelectionStyle.blue
            cell.textLabel?.text = "Blue"
        case 2:
            cell.selectionStyle = UITableViewCellSelectionStyle.gray
            cell.textLabel?.text = "Gray"
        default:
            cell.selectionStyle = UITableViewCellSelectionStyle.default
            cell.textLabel?.text = "Default"
        }
        return cell!
    }
    
    // MARK: 3 UITableViewCellAccessoryType
    func tableViewCellWithAccessoryType(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!  = tableView.dequeueReusableCell(withIdentifier: "AccessoryType")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "AccessoryType")
        }
        switch indexPath.row {
        case 0:
            cell.accessoryType = UITableViewCellAccessoryType.none // 右变的小图标
            cell.textLabel?.text = "None"
        case 1:
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.textLabel?.text = "DisclosureIndicator"
        case 2:
            cell.accessoryType = UITableViewCellAccessoryType.detailDisclosureButton
            cell.textLabel?.text = "DetailDisclosureButton"
        case 3:
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            cell.textLabel?.text = "Checkmark"
        default:
            cell.accessoryType = UITableViewCellAccessoryType.detailButton
            cell.textLabel?.text = "DetailButton"
        }
        cell.editingAccessoryType = cell.accessoryType // 编辑模式下的小图标，默认.None
        return cell!
    }
    
    // MARK: 5 Managing Content Indentation
    func tableViewCellWithManagingContentIndentation(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!  = tableView.dequeueReusableCell(withIdentifier: "MCIndentation")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "MCIndentation")
        }
        cell.textLabel?.text = "\(indexPath.section)--\(indexPath.row)"
        cell.indentationLevel = indexPath.row // 缩进的级别
        cell.indentationWidth = 10.0 * CGFloat(indexPath.section+1) // 缩进的基数,默认10.0
        cell.shouldIndentWhileEditing = false // 编辑模式是否缩进，默认true
        return cell!
    }
    
    // MARK: 6 带switch样式的cell
    func tableViewCellWithSwitch(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        // 注册的cell可直接提取
        let cell = tableView.dequeueReusableCell(withIdentifier: "YJSwitchTableViewCell") as! YJSwitchTableViewCell
        cell.titleLabel.text = "\(indexPath.section)--\(indexPath.row)"
        cell.indexPath = indexPath
        // 监听
        cell.handler = { (cell: YJSwitchTableViewCell) -> Void in
            print("\(cell.yjSwitch.isOn):\(indexPath.section)--\(indexPath.row)")
        }
        return cell
    }
    
}
