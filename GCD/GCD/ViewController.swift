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
    
    private static var once = ViewController() // 单例模式
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var queue: DispatchQueue = DispatchQueue.main// 主线程
        if #available(iOS 8.0, *) {
            queue = DispatchQueue.global()
        } else {
            queue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background)// 后台执行
        }
        
        // 异步执行队列任务
        queue.async {
            print("开新线程执行")
        }
        
        
        // 延时执行
        var delta:Int64 = Int64(2 * NSEC_PER_SEC)// 2s后执行,可能不仅限于2s
        delta = Int64(100 * NSEC_PER_MSEC)//100毫秒后执行
        // NSEC_PER_MSEC
        let when: DispatchTime = DispatchTime.now() + Double(delta) / Double(NSEC_PER_SEC)
        queue.asyncAfter(deadline: when) {
            print("dispatch_after")
        }
        
    
        // 分组执行
        let group = DispatchGroup()
        queue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default)// 默认优先级执行
        for i in 0 ..< 10 {
            //异步执行队列任务
            queue.async(group: group, execute: {
                print("queue.async(group: group \(i)")
            })
        }
        // 分组队列执行完毕后执行
        group.notify(queue: queue) {
            print("dispatch_group_notify")
        }
        
        
        // 串行队列：只有一个线程，加入到队列中的操作按添加顺序依次执行。
        let serialQueue = DispatchQueue(label: "yangj", attributes: [])
        for i in 0 ..< 10 {
            //异步执行队列任务
            serialQueue.async {
                print("serialQueue.async \(i)")
            }
        }
        
        
        // 并发队列：有多个线程，操作进来之后它会将这些队列安排在可用的处理器上，同时保证先进来的任务优先处理。
        let globalQueue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default)
        for i in 0 ..< 10 {
            //异步执行队列任务
            globalQueue.async {
                print("globalQueue.async \(i)")
            }
        }
        
    }
    
}

