//
//  YJOperationVC.swift
//  YJFoundation
//
//  Created by yangjun on 16/2/1.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit

/// NSOperation
class YJOperationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let oq = OperationQueue.current { // 当前队列
            oq.addOperation({ () -> Void in
                print("0")
            })
            let op = BlockOperation() // block任务
            // 添加block
            op.addExecutionBlock { () -> Void in
                print("1")
            }
            op.addExecutionBlock { () -> Void in
                print("2")
            }
            oq.addOperation(op)
        }
    }

}
