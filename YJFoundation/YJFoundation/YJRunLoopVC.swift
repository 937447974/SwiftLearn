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
        RunLoop.current.perform(#selector(YJRunLoopVC.send(_:)), target: self, argument: "937447974", order: 0, modes: [RunLoopMode.defaultRunLoopMode])
        self.performSelector(inBackground: #selector(YJRunLoopVC.send(_:)), with: "阳君")
    }
    
    func send(_ str: String) {
        print("接受数据：\(str)")
    }
    
}
