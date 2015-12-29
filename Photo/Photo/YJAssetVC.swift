//
//  YJAssetVC.swift
//  Photo
//
//  Created by yangjun on 15/12/28.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

/// 照片或视频
class YJAssetVC: UIViewController {
    
    /// 相册
    var assetCollection: PHAssetCollection!
    /// 照片
    var asset: PHAsset! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var livePhotoView: PHLivePhotoView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
