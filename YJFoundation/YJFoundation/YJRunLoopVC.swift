//
//  YJRunLoopVC.swift
//  YJFoundation
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// NSRunLoop
class YJRunLoopVC: UIViewController {
    
    var loading = true

    override func viewDidLoad() {
        super.viewDidLoad()
        NSRunLoop.currentRunLoop().performSelector("send:", target: self, argument: "937447974", order: 0, modes: [NSDefaultRunLoopMode])
        self.performSelectorInBackground("send:", withObject: "阳君")
    }
    
    func send(str: String) {
        print("接受数据：\(str)")
    }
    
}
