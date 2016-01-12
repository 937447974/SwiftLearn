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

class ViewController: UIViewController,  MFMailComposeViewControllerDelegate {
    
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
    @IBAction func composeMail(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() { // 判断能否发送邮件
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
            self.presentViewController(mailVC, animated: true, completion: nil)
        } else {
            print("不能发送邮件")
        }
    }
    
    // MARK: compose message
    @IBAction func composeMessage(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            
        } else {
            print("不能发送邮件")
        }
    }
    
    // MARK: -  MFMailComposeViewControllerDelegate
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        // 关闭MFMailComposeViewController
        controller.dismissViewControllerAnimated(true, completion: nil)
        guard error == nil else { // 错误拦截
            print(error)
            return
        }
        switch result { // 发送状态
        case MFMailComposeResultCancelled:
            print("Result: Mail sending canceled") // 删除草稿
        case MFMailComposeResultSaved: // 存储草稿
            print("Result: Mail saved")
        case MFMailComposeResultSent: // 发送成功
            print("Result: Mail sent")
        case MFMailComposeResultFailed: // 发送失败
            print("Result: Mail sending failed")
        default:// 其他
            print("Result: Mail not sent")
        }
    }
    
}

