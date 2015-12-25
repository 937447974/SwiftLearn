//
//  YJMasterVC.swift
//  ViewRotation
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/25.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

/// 第一页
class YJMasterVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        let vc = YJDetailVC()
        vc.view.backgroundColor = UIColor.whiteColor()
//        self.navigationController?.pushViewController(vc, animated: true)
//        self.navigationController?.showDetailViewController(vc, sender: nil)
        self.presentViewController(vc, animated: true, completion: nil)
    }

}
