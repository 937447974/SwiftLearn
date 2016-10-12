//
//  YJThreadVC.swift
//  YJFoundation
//
//  Created by yangjun on 16/1/30.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

class YJThreadVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 方式一
        let thread = Thread(target: self, selector: #selector(YJThreadVC.send(_:)), object: "阳君")
        print("线程开销：\(thread.stackSize)bytes")
        thread.start() // 执行
        
        // 方式二
        Thread.detachNewThreadSelector(#selector(YJThreadVC.send(_:)), toTarget: self, with: "937447974")
        
        // 方式三
        // 参考协议NSObjectProtocol
        self.perform(#selector(YJThreadVC.send(_:)), with: "直接发送")
    }
    
    func send(_ str: String) {
        print("是否主线程：\(Thread.isMainThread),接受数据：\(str)")
    }

}
