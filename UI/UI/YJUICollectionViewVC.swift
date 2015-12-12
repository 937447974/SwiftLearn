//
//  YJUICollectionViewVC.swift
//  UI
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/12.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

class YJUICollectionViewVC: UIViewController {

    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cvLayout = UICollectionViewLayout()
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: cvLayout)
        self.collectionView.backgroundColor = self.view.backgroundColor
        self.view.addSubview(self.collectionView)
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
