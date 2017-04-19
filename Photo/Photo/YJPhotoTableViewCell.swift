//
//  YJPhotoTableViewCell.swift
//  Photo
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/28.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// YJPhotoTableViewCell的NibName
let YJPhotoTableViewCellNibName = "YJPhotoTableViewCell"

/// 照片Cell
class YJPhotoTableViewCell: UITableViewCell {
    
    /// 照片
    @IBOutlet weak var photoImageView: UIImageView!
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 数量
    @IBOutlet weak var countLabel: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
