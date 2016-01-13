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

class YJContactVC: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    /// 数据源
    private var data = [CNContact]()
    /// 通讯录存储库
    private let store = CNContactStore()
    /// 快速查询
    private var predicate: NSPredicate! {
        didSet {
            print(self.predicate)
            do {
                self.data = try self.store.unifiedContactsMatchingPredicate(self.predicate, keysToFetch:[CNContactGivenNameKey, CNContactFamilyNameKey])
                self.tableView.reloadData()
            } catch {
                print("未知错误：\(error)")
            }
        }
    }
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "contactStoreDidChangeNotification", name: CNContactStoreDidChangeNotification, object: nil)
        self.contactStoreDidChangeNotification()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - NSNotificationCenter
    // MARK: 通讯录有变动
    func contactStoreDidChangeNotification() {
        print(__FUNCTION__)
        self.predicate = CNContact.predicateForContactsInContainerWithIdentifier(self.store.defaultContainerIdentifier()) //predicateForContactsMatchingName("")
    }
    
    // MARK: - Action
    // MARK: 添加电话
    @IBAction func onClickAdd(sender: AnyObject) {
        // Creating a mutable object to add to the contact
        let contact = CNMutableContact()
        contact.contactType = CNContactType.Person // 类型
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
        let workEmail = CNLabeledValue(label:CNLabelWork, value:"937447974@qq.com") // 工作
        contact.emailAddresses = [workEmail]
        
        // 家庭地址
        let homeAddress = CNMutablePostalAddress()
        homeAddress.street = "西城区" // 街道
        homeAddress.city = "北京" // 城市
        homeAddress.state = "北京"// 省
        homeAddress.postalCode = "000000" // 邮编
        contact.postalAddresses = [CNLabeledValue(label:CNLabelHome, value:homeAddress)] // 添加地址
        
        // 生日
        let birthday = NSDateComponents()
        birthday.year = 2016
        birthday.month = 1
        birthday.day = 12
        contact.birthday = birthday
        
        // Saving the newly created contact
        do {
            let saveRequest = CNSaveRequest()
            saveRequest.addContact(contact, toContainerWithIdentifier:self.store.defaultContainerIdentifier())
            try self.store.executeSaveRequest(saveRequest)
        } catch {
            print("未知错误：\(error)")
        }
    }
    
    // MARK: - UISearchBarDelegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
            self.predicate = CNContact.predicateForContactsInContainerWithIdentifier(self.store.defaultContainerIdentifier())
        } else {
            self.predicate = CNContact.predicateForContactsMatchingName(searchBar.text!)
        }
    }
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "reuseIdentifier"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        }
        let contact = self.data[indexPath.row]
        cell?.textLabel?.text = "\(contact.familyName)\(contact.givenName)"
        return cell!
    }
    
    // Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // 删除电话
            do {
                // 删除通讯录中电话
                let saveRequest = CNSaveRequest()
                let contact = self.data[indexPath.row].mutableCopy() as! CNMutableContact
                saveRequest.deleteContact(contact)
                // 刷新UI
                self.data.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                //
                try self.store.executeSaveRequest(saveRequest)
            } catch {
                print("未知错误：\(error)")
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
}
