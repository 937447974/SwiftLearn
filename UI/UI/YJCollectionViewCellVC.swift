//
//  YJCollectionViewCellVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/19.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// 自定义UICollectionViewCell
class YJCollectionViewCellVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "YJCollectionViewCell", bundle: nil)
        self.collectionView?.register(nib, forCellWithReuseIdentifier: "customCell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! YJCollectionViewCell
        cell.backgroundColor = UIColor.gray
        cell.textLabel.text = "\(indexPath.item)"
        return cell
    }

}
