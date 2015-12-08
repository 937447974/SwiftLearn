//
//  ViewController.swift
//  GCD
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/8.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var queue: dispatch_queue_t = dispatch_get_main_queue()// 主线程
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)// 后台执行
        
        
        // 异步执行队列任务
        dispatch_async(queue, { () -> Void in
            print("开新线程执行")
        })
        
        
        // 延时执行
        var delta:Int64 = Int64(2 * NSEC_PER_SEC)// 2s后执行,可能不仅限于2s
        delta = Int64(100 * NSEC_PER_MSEC)//100毫秒后执行
        // NSEC_PER_MSEC
        let when: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, delta)
        dispatch_after(when, queue) { () -> Void in
            print("dispatch_after")
        }
        
        
        // 只执行一次
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var value: String!
        }
        dispatch_once(&Static.onceToken, { () -> Void in
            Static.value = "单例模式"
        })
        print("\(Static.value)")
        dispatch_once(&Static.onceToken, { () -> Void in
            Static.value = "改变值"
        })
        print("\(Static.value)")
        
        
        // 分组执行
        let group = dispatch_group_create()
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)// 默认优先级执行
        for (var i = 0; i<10; i++) {
            //异步执行队列任务
            dispatch_group_async(group, queue, { () -> Void in
                Static.value = Static.value + "1"
                print("\(Static.value)")
            })
        }
        // 分组队列执行完毕后执行
        dispatch_group_notify(group, queue) { () -> Void in
            print("dispatch_group_notify")
        }
        
        
        // 串行队列：只有一个线程，加入到队列中的操作按添加顺序依次执行。
        let serialQueue = dispatch_queue_create("yangj", DISPATCH_QUEUE_SERIAL)
        for (var i = 0; i<10; i++) {
            //异步执行队列任务
            dispatch_async(serialQueue, { () -> Void in
                //Static.value = Static.value + "1"
                //println("\(Static.value)")
            })
        }
        
        
        // 并发队列：有多个线程，操作进来之后它会将这些队列安排在可用的处理器上，同时保证先进来的任务优先处理。
        let globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        for (var i = 0; i<10; i++) {
            //异步执行队列任务
            dispatch_async(globalQueue, { () -> Void in
                //Static.value = Static.value + "1"
                //println("\(Static.value)")
            })
        }
        
    }
    
}

