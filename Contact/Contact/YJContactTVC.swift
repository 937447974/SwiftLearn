//
//  YJContactTVC.swift
//  Contact
//
//  Created by yangjun on 16/1/12.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import Contacts

/// 主界面
class YJContactTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
    
        contact.givenName = "阳君"
        contact.familyName = "IOS"
        
        // 电话
        let homePhone = CNLabeledValue(label:CNLabelPhoneNumberiPhone, value:CNPhoneNumber(stringValue:"18511056826"))
        contact.phoneNumbers = [homePhone]
        
        // 邮件
        let homeEmail = CNLabeledValue(label:CNLabelHome, value:"john@example.com") // 住宅
        let workEmail = CNLabeledValue(label:CNLabelWork, value:"j.appleseed@icloud.com") // 工作
        contact.emailAddresses = [homeEmail, workEmail]
        
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
            let store = CNContactStore()
            let saveRequest = CNSaveRequest()
            saveRequest.addContact(contact, toContainerWithIdentifier:"contact")
            try store.executeSaveRequest(saveRequest)
        } catch {
            print(error)
        }
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
