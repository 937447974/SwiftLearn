//
//  YJContactVC.swift
//  Contact
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/13.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import Contacts

/// 通讯录
class YJContactVC: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    /// UITableView
    @IBOutlet weak var tableView: UITableView!
    /// 数据源
    fileprivate var data = [CNContact]()
    /// 通讯录存储库
    fileprivate let store = CNContactStore()
    /// 快速查询
    fileprivate var predicate: NSPredicate! {
        didSet {
            do {
                self.data = try self.store.unifiedContacts(matching: self.predicate, keysToFetch:[CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor])
                self.tableView.reloadData()
            } catch {
                print("未知错误：\(error)")
            }
        }
    }
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(YJContactVC.contactStoreDidChangeNotification), name: NSNotification.Name.CNContactStoreDidChange, object: nil)
        self.contactStoreDidChangeNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - NSNotificationCenter
    // MARK: 通讯录有变动
    func contactStoreDidChangeNotification() {
        print(#function)
        self.predicate = CNContact.predicateForContactsInContainer(withIdentifier: self.store.defaultContainerIdentifier()) //predicateForContactsMatchingName("")
    }
    
    // MARK: - Action
    // MARK: 添加电话
    @IBAction func onClickAdd(_ sender: AnyObject) {
        // Creating a mutable object to add to the contact
        let contact = CNMutableContact()
        contact.contactType = CNContactType.person // 类型
        // 照片
        if let image = UIImage(named: "qq") {
            if let data = UIImagePNGRepresentation(image) {
                contact.imageData = data
            }
        }
        contact.familyName = "阳" // 姓
        contact.givenName = "君" // 名
        contact.jobTitle = "IOS攻城师" // 工作
        // 电话
        let homePhone = CNLabeledValue(label:CNLabelPhoneNumberMobile, value:CNPhoneNumber(stringValue:"185-1105-6826"))
        contact.phoneNumbers = [homePhone]
        
        // 邮件
        let workEmail = CNLabeledValue(label:CNLabelWork, value:"937447974@qq.com" as NSString) // 工作
        contact.emailAddresses = [workEmail]
        
        // 家庭地址
        let homeAddress = CNMutablePostalAddress()
        homeAddress.street = "西城区" // 街道
        homeAddress.city = "北京" // 城市
        homeAddress.state = "北京"// 省
        homeAddress.postalCode = "000000" // 邮编
        contact.postalAddresses = [CNLabeledValue(label:CNLabelHome, value:homeAddress)] // 添加地址
        
        // 生日
        var birthday = DateComponents()
        birthday.year = 2016
        birthday.month = 1
        birthday.day = 12
        contact.birthday = birthday
        
        // Saving the newly created contact
        do {
            let saveRequest = CNSaveRequest()
            saveRequest.add(contact, toContainerWithIdentifier:self.store.defaultContainerIdentifier())
            try self.store.execute(saveRequest)
        } catch {
            print("未知错误：\(error)")
        }
    }
    
    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text?.lengthOfBytes(using: String.Encoding.utf8) == 0 {
            self.predicate = CNContact.predicateForContactsInContainer(withIdentifier: self.store.defaultContainerIdentifier())
        } else {
            self.predicate = CNContact.predicateForContacts(matchingName: searchBar.text!)
        }
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "reuseIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        let contact = self.data[indexPath.row]
        cell?.textLabel?.text = "\(contact.familyName)\(contact.givenName)" // CNContactFormatter.stringFromContact(contact, style: .FullName)
        return cell!
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 删除电话
            do {
                // 删除通讯录中电话
                let saveRequest = CNSaveRequest()
                let contact = self.data[indexPath.row].mutableCopy() as! CNMutableContact
                saveRequest.delete(contact)
                // 刷新UI
                self.data.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                // 保存
                try self.store.execute(saveRequest)
            } catch {
                print("未知错误：\(error)")
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
}
