//
//  Swift.swift
//  OC_Swift
//
//  Created by 阳君 on 14/11/11.
//  Copyright (c) 2014年 北京宏景世纪软件股份有限公司. All rights reserved.
//

import Foundation

class Swift: NSObject {
    
    func test(_ str:String) {
        print("Swift:\(str)")
        // 混编Object-C
        let oc = Objective()
        oc.test(str)
    }
}
