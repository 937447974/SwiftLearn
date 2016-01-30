//
//  ViewController.swift
//  YJCoreTelephony
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/29.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import CoreTelephony

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let callCenter = CTCallCenter()
        callCenter.callEventHandler = { (call: CTCall) -> Void in
            print("状态:\(call.callState)；标示符：\(call.callID)")
            print(callCenter.currentCalls)
        }
        let tNetInfo = CTTelephonyNetworkInfo()
        // 输出手机的数据业务信息
        print("Radio Access Technology:\(tNetInfo.currentRadioAccessTechnology)")
        // 获取运营商相关
        if let carrier = tNetInfo.subscriberCellularProvider {
            print("是否允许VOIP：\(carrier.allowsVOIP)")
            print(carrier.carrierName)
        }
        // 获取授权token
        if let token = CTSubscriber().carrierToken {
            print("用户授权信息：\(NSString(data: token, encoding: NSUTF8StringEncoding))")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

