//
//  YJPhotosVC.swift
//  Photo
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/8.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit
import Photos

/// 照片
class YJPhotosVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 精选
        var fetchResult: PHFetchResult = PHCollectionList.fetchMomentListsWithSubtype(PHCollectionListSubtype.MomentListCluster, options: nil)
        fetchResult.enumerateObjectsUsingBlock { (obj: AnyObject, index: Int, umPointer: UnsafeMutablePointer<ObjCBool>) -> Void in
            print(obj)
        }
        
        // 年度
        print("======")
        fetchResult = PHCollectionList.fetchMomentListsWithSubtype(PHCollectionListSubtype.MomentListYear, options: nil)
        fetchResult.enumerateObjectsUsingBlock { (obj: AnyObject, index: Int, umPointer: UnsafeMutablePointer<ObjCBool>) -> Void in
            print(obj)
        }
        
        print("时刻")
        fetchResult = PHAssetCollection.fetchMomentsWithOptions(nil)
        fetchResult.enumerateObjectsUsingBlock { (obj: AnyObject, index: Int, umPointer: UnsafeMutablePointer<ObjCBool>) -> Void in
            print(obj)
        }
      
    }
    
    override func viewDidAppear(animated: Bool) {
        print(__FUNCTION__)
    }
    
    override func viewDidDisappear(animated: Bool) {
        print(__FUNCTION__)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
