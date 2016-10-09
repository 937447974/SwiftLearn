//
//  InterfaceController.swift
//  WatchKit Extension
//
//  Created by admin on 2016/10/9.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var iLable: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if WCSession.isSupported() {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print(activationState.rawValue)
        print("\(#function) \(error)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Swift.Void) {
        print("\(#function) \(message)")
        replyHandler(["message":"WatchKit接收数据", "data":message])
        self.iLable.setText(message["data"] as? String ?? "数据传输错误")
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("\(#function) \(userInfo)")
        self.iLable.setText(userInfo["data"] as? String ?? "数据传输错误")
    }

}
