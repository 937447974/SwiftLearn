//
//  ViewController.swift
//  YJMultipeerConnectivity
//
//  Created by yangjun on 16/1/21.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCBrowserViewControllerDelegate, MCSessionDelegate {

    /// 视图控制器，处理和协调对链接的浏览
    private var browser: MCBrowserViewController!
    /// 广播和协调对连接和会话的建立
    private var asistant: MCAdvertiserAssistant!
    /// 会话
    private var session: MCSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 会话中的ID，使用设备名称
        let peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        
        
        
        
        self.session = MCSession(peer: peerID)
        self.session.delegate = self
        
        // 创建浏览器视图控制器，它有一个独一无二的服务台
        self.browser = MCBrowserViewController(serviceType: "YangJun", session: self.session)
        self.browser.delegate = self
        self.asistant = MCAdvertiserAssistant(serviceType: "YangJun", discoveryInfo: nil, session: self.session)
        
       
    }
    
   
    
    @IBAction func onClickSearch(sender: AnyObject) {
        // 告诉助理编辑器，开始广播聊天服务
        self.asistant.start()
        self.presentViewController(self.browser, animated: true, completion: nil)
    }
 
    @IBAction func onClickStop(sender: AnyObject) {
        self.asistant.stop()
    }

    // MARK: - MCSessionDelegate
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        // 当一个已连接的对等节点改变状态时调用
        print(__FUNCTION__)
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        // 收到Data数据,主线程运行
        print(__FUNCTION__)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if let msg = NSString(data: data, encoding: NSUTF8StringEncoding) {
//                self.updateChat(msg as String, formPeer: peerID)
            }
        })
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // 当对等节点与我们建立一个流时调用
        print(__FUNCTION__)
    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        // 当一个对等节点向我们发送文件时调用
        print(__FUNCTION__)
    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        // 在完成从另一个对等节点传送文件时调用
        print(__FUNCTION__)
    }
    
    func session(session: MCSession, didReceiveCertificate certificate: [AnyObject]?, fromPeer peerID: MCPeerID, certificateHandler: (Bool) -> Void) {
        print(__FUNCTION__)
        certificateHandler(true)
    }
    
    // MARK: - MCBrowserViewControllerDelegate
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController) {
        // Notifies the delegate, when the user taps the done button
        print(__FUNCTION__)
        browserViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Notifies delegate that the user taps the cancel button.
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController) {
        // Notifies delegate that the user taps the cancel button.
        print(__FUNCTION__)
        browserViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func browserViewController(browserViewController: MCBrowserViewController, shouldPresentNearbyPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) -> Bool {
        return true
    }
    
}

