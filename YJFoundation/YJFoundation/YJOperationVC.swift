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
        NSOperation
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @available(iOS 2.0, *)
    public class NSOperation : NSObject {
        
        public func start()
        public func main()
        
        public var cancelled: Bool { get }
        public func cancel()
        
        public var executing: Bool { get }
        public var finished: Bool { get }
        public var concurrent: Bool { get } // To be deprecated; use and override 'asynchronous' below
        @available(iOS 7.0, *)
        public var asynchronous: Bool { get }
        public var ready: Bool { get }
        
        public func addDependency(op: NSOperation)
        public func removeDependency(op: NSOperation)
        
        public var dependencies: [NSOperation] { get }
        
        public var queuePriority: NSOperationQueuePriority
        
        @available(iOS 4.0, *)
        public var completionBlock: (() -> Void)?
        
        @available(iOS 4.0, *)
        public func waitUntilFinished()
        
        @available(iOS, introduced=4.0, deprecated=8.0)
        public var threadPriority: Double
        
        @available(iOS 8.0, *)
        public var qualityOfService: NSQualityOfService
        
        @available(iOS 8.0, *)
        public var name: String?
    }

}
