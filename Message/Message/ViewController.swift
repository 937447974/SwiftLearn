//
//  ViewController.swift
//  Message
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/11.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController,  MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    // MARK: compose mail
    @IBAction func composeMail(_ sender: AnyObject) {
        // 判断能否发送邮件
        guard MFMailComposeViewController.canSendMail() else {
            print("不能发送邮件")
            return
        }
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self // 代理
        mailVC.setSubject("阳君") // 主题
        mailVC.setToRecipients(["937447974@qq.com"]) // 收件人
        mailVC.setCcRecipients(["CcRecipients@qq.com"]) // 抄送
        mailVC.setBccRecipients(["bccRecipients@qq.com"]) // 密送
        mailVC.setMessageBody("相关内容", isHTML: false) // 内容，允许使用html内容
        if let image = UIImage(named: "qq") {
            if let data = UIImagePNGRepresentation(image) {
                // 添加文件
                mailVC.addAttachmentData(data, mimeType: "image/png", fileName: "qq")
            }
        }
        self.present(mailVC, animated: true, completion: nil)
    }
    
    // MARK: compose message
    @IBAction func composeMessage(_ sender: AnyObject) {
        guard MFMessageComposeViewController.canSendText() else {
            print("不能发送短信")
            return
        }
        let messageVC = MFMessageComposeViewController()
        messageVC.messageComposeDelegate = self // 代理
        messageVC.recipients = ["18511056826"] // 收件人
        messageVC.body = "短信内容" // 内容
        // 发送主题
        if MFMessageComposeViewController.canSendSubject() {
            messageVC.subject = "阳君"
        }
        // 发送附件
        if MFMessageComposeViewController.canSendAttachments() {
            // 路径添加
            if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
                messageVC.addAttachmentURL(URL(fileURLWithPath: path), withAlternateFilename: "Info.plist")
            }
            // NSData添加
            if MFMessageComposeViewController.isSupportedAttachmentUTI("public.png") {
                // See [Uniform Type Identifiers Reference](https://developer.apple.com/library/ios/documentation/Miscellaneous/Reference/UTIRef/Introduction/Introduction.html)
                if let image = UIImage(named: "qq") {
                    if let data = UIImagePNGRepresentation(image) {
                        // 添加文件
                        messageVC.addAttachmentData(data, typeIdentifier: "public.png", filename: "qq.png")
                    }
                }
            }
        }
        // messageVC.disableUserAttachments() // 禁用添加附件按钮
        self.present(messageVC, animated: true, completion: nil)
    }
    
    // MARK: -  MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // 关闭MFMailComposeViewController
        controller.dismiss(animated: true, completion: nil)
        guard error == nil else { // 错误拦截
            print(error!)
            return
        }
        switch result { // 发送状态
        case MFMailComposeResult.cancelled:
            print("Result: Mail sending canceled") // 删除草稿
        case MFMailComposeResult.saved: // 存储草稿
            print("Result: Mail saved")
        case MFMailComposeResult.sent: // 发送成功
            print("Result: Mail sent")
        case MFMailComposeResult.failed: // 发送失败
            print("Result: Mail sending failed")
        }
    }
    
    // MARK: - MFMessageComposeViewControllerDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        print(controller.attachments as Any) // 所有附件
        // 关闭MFMessageComposeViewController
        controller.dismiss(animated: true, completion: nil)
        switch result { // 发送状态
        case MessageComposeResult.cancelled:
            print("Result: Mail sending cancelled") // 取消发送
        case MessageComposeResult.sent: // 发送成功
            print("Result: Mail sent")
        case MessageComposeResult.failed: // 发送失败
            print("Result: Message sending failed")
        }
    }
    
}

