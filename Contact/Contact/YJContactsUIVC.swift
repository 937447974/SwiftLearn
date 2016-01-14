//
//  YJContactsUIVC.swift
//  Contact
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/14.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import ContactsUI

/// ContactsUI显示
class YJContactsUIVC: UIViewController, CNContactPickerDelegate, CNContactViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Action
    // MARK: CNContactPickerViewController 测试
    @IBAction func onClickCNContactPickerViewController(sender: AnyObject) {
        // 选择联系人或联系人的属性（如电话号码）
        let vc = CNContactPickerViewController()
        vc.delegate = self // 根据实现的代理方法指定单选、多选
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // MARK: CNContactViewController 测试
    @IBAction func onClickCNContactViewController(sender: AnyObject) {
        // 创建或修改联系人
        let vc = CNContactViewController(forNewContact: nil)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - CNContactPickerDelegate
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        // 单选
        print(contact)
    }
    
    // MARK: - CNContactViewControllerDelegate
    func contactViewController(viewController: CNContactViewController, shouldPerformDefaultActionForContactProperty property: CNContactProperty) -> Bool {
        print(__FUNCTION__)
        print(property)
        return true
    }
    
    func contactViewController(viewController: CNContactViewController, didCompleteWithContact contact: CNContact?) {
        viewController.navigationController?.popViewControllerAnimated(true)
        print(__FUNCTION__)
        print(contact)
    }
    
}
