//
//  ViewController.swift
//  YJWatchConnectivity
//
//  Created by admin on 2016/10/9.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, UITextViewDelegate, WCSessionDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if WCSession.isSupported() {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }
    }
    
    // MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        let session = WCSession.default()
        if session.isReachable {
            session.sendMessage(["data" : textView.text], replyHandler: { (replyHandler: [String : Any]) in
                print(replyHandler)
            }) { (error: Error) in
                print(error)
            }
//            session.transferUserInfo(["data" : textView.text]) // 队列模式
        }        
    }
    
    // MARK: - WCSessionDelegate
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print(activationState.rawValue)
        print("\(#function) \(error)")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print(#function)
    }
    
    public func sessionDidDeactivate(_ session: WCSession) {
        print(#function)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("\(#function) \(message)")
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("\(#function) \(userInfo)")
    }
    
}

