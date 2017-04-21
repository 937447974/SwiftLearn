//
//  YJSwitchTableViewCell.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/16.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

class YJSwitchTableViewCell: UITableViewCell {
    
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 按钮
    @IBOutlet weak var yjSwitch: UISwitch!
    /// cell的位置
    var indexPath: IndexPath?
    /// 闭包回调
    var handler: ((YJSwitchTableViewCell) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none // 点击无颜色变化
    }
    
    @IBAction func onClickSwitch(_ sender: AnyObject) {
        self.handler?(self)
    }
    
}
