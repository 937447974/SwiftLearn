//
//  ViewController.swift
//  YJMultipeerConnectivity
//
//  Created by yangjun on 16/1/21.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import MultipeerConnectivity

/// 房间
let MCServiceType = "YangJun"

class ViewController: UIViewController, UITextFieldDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate {
    
    /// 距底边位置
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    /// 显示内容
    @IBOutlet weak var textView: UITextView!
    /// 广播和协调对连接和会话的建立
    private var asistant: MCAdvertiserAssistant!
    /// 会话
    private var session: MCSession!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        // 会话中的ID，使用设备名称
        let peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        self.session = MCSession(peer: peerID)
        self.session.delegate = self
        self.asistant = MCAdvertiserAssistant(serviceType: MCServiceType, discoveryInfo: nil, session: self.session)
        self.asistant.start()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - Action
    // MARK: 连接附近的设备
    @IBAction func onClickSearch(sender: AnyObject) {
        // 告诉助理编辑器，开始广播聊天服务
        self.asistant.start()
        // 创建浏览器视图控制器，它有一个独一无二的服务台
        let browserVC = MCBrowserViewController(serviceType: MCServiceType, session: self.session)
        browserVC.delegate = self
        self.presentViewController(browserVC, animated: true, completion: nil)
    }
    
    // MARK: 停止连接
    @IBAction func onClickStop(sender: AnyObject) {
        self.asistant.stop() // 停止广播
        self.session.disconnect() // 断开连接
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 失去焦点
        let text = textField.text ?? ""
        textField.text = nil
        // 更新UI
        let message = "\(self.session.myPeerID.displayName): \(text)\n"
        self.textView.text = self.textView.text + message
        // 发送数据
        if self.session.connectedPeers.count != 0 { // 有接受对象则发送消息
            guard let data = text.dataUsingEncoding(NSUTF8StringEncoding) else {
                print("\(text) 转换出错")
                return true
            }
            do {
                try self.session.sendData(data, toPeers: self.session.connectedPeers, withMode: MCSessionSendDataMode.Unreliable)
            } catch {
                print(error)
            }
        }
        return true
    }
    
    // MARK: - MCSessionDelegate
    // MARK: 连接状态
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        // 当一个已连接的对等节点改变状态时调用
        print(#function)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            switch state {
            case MCSessionState.NotConnected: // not in the session
                self.textView.text = self.textView.text + "\(peerID.displayName)离开聊天室\n"
            case MCSessionState.Connecting: // connecting to this peer
                self.textView.text = self.textView.text + "\(peerID.displayName)正在加入聊天室\n"
            case MCSessionState.Connected: // connected to the session
                self.textView.text = self.textView.text + "\(peerID.displayName)已加入聊天室\n"
            }
        })
    }
    
    // MARK: 接受NSData数据
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        // 收到Data数据,主线程运行
        print(#function)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if let msg = NSString(data: data, encoding: NSUTF8StringEncoding) {
                // 更新UI
                let message = "\(peerID.displayName): \(msg)\n"
                self.textView.text = self.textView.text + message
            }
        })
    }
    
    // MARK: 接受流数据
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // 当对等节点与我们建立一个流时调用
        print(#function)
    }
    
    // MARK: 开始接受文件数据
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        // 当一个对等节点向我们发送文件时调用
        print(#function)
    }
    
    // MARK: 文件数据接受完毕
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        // 在完成从另一个对等节点传送文件时调用
        print(#function)
    }
    
    // MARK: - MCBrowserViewControllerDelegate
    // MARK: 点击MCBrowserViewController界面取消按钮
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController) {
        print(#function)
        browserViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: 点击MCBrowserViewController界面完成按钮
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController) {
        print(#function)
        browserViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Keyboard
    // MARK: 显示键盘
    func keyboardWillShow(notification: NSNotification) {
        self.moveToolBarUp(true, forKeyboardNotification: notification)
    }
    
    // MARK: 隐藏键盘
    func keyboardWillHide(notification: NSNotification) {
        self.moveToolBarUp(false, forKeyboardNotification: notification)
    }
    
    // MARK: 键盘升降引起的动画
    private func moveToolBarUp(up: Bool, forKeyboardNotification notification: NSNotification) {
        if let userInfo = notification.userInfo {
            guard userInfo[UIKeyboardAnimationCurveUserInfoKey]!.boolValue == true else {
                print("多任务开启键盘")
                return
            }
            guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval else {
                print("UIKeyboardAnimationDurationUserInfoKey转换出错")
                return
            }
            guard let curveInt = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int else {
                print("UIKeyboardAnimationCurveUserInfoKey转换出错")
                return
            }
            guard let curve = UIViewAnimationCurve(rawValue: curveInt) else {
                print("UIViewAnimationCurve生成出错")
                return
            }
            guard let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height else {
                print("UIKeyboardFrameEndUserInfoKey转换出错")
                return
            }
            // 动画
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(duration)
            UIView.setAnimationCurve(curve)
            self.bottomLayoutConstraint.constant = up ? 10 + keyboardHeight : 15
            UIView.commitAnimations()
        }
    }
    
}

