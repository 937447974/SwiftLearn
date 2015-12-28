//
//  YJPhotoCollectionViewCell.swift
//  Photo
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/25.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// YJPhotoCollectionViewCell的NibName
let YJPhotoCollectionViewCellNibName = "YJPhotoCollectionViewCell"

/// 照片cell
class YJPhotoCollectionViewCell: UICollectionViewCell {
    
    /// 照片
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
