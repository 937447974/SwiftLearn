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
    @IBAction func onClickCNContactPickerViewController(_ sender: AnyObject) {
        // 选择联系人或联系人的属性（如电话号码）
        let vc = CNContactPickerViewController()
        vc.delegate = self // 根据实现的代理方法指定单选、多选
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: CNContactViewController 测试
    @IBAction func onClickCNContactViewController(_ sender: AnyObject) {
        // 创建或修改联系人
        let vc = CNContactViewController(forNewContact: nil)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - CNContactPickerDelegate
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        // 单选
        print(contact)
    }
    
    // MARK: - CNContactViewControllerDelegate
    func contactViewController(_ viewController: CNContactViewController, shouldPerformDefaultActionFor property: CNContactProperty) -> Bool {
        print(#function)
        print(property)
        return true
    }
    
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        viewController.navigationController?.popViewController(animated: true)
        print(#function)
        print(contact as Any)
    }
    
}
