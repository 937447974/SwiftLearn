//
//  YJPhotoAlbumsVC.swift
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

/// cell的模型数据
private class YJPhotoAlbumsCellModel {
    
    /// 照片
    var image: UIImage?
    /// 标题
    var text: String?
    /// 描述
    var detailText: String?
    /// 对应的相薄
    var assetCollection: PHAssetCollection!
    
}

/// 相薄
class YJPhotoAlbumsVC: UIViewController, PHPhotoLibraryChangeObserver, UITableViewDataSource, UITableViewDelegate {
    
    /// tableView
    @IBOutlet weak var tableView: UITableView!
    /// 组内成员
    private var sectionFetchResults = [PHFetchResult]()
    /// tableView的Header标题
    private var dataTitleForHeader = [String]()
    /// tableView的数据源
    private var data = Array<Array<YJPhotoAlbumsCellModel>>()
    /// tableView数据源对应的PHAssetCollection集合
    private var dataFetchResults = [PHFetchResult]()
    
    // MARK: - viewDid
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "onClickAddCollectionList")
        // 注册cell
        let nib = UINib(nibName: YJPhotoTableViewCellNibName, bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "photoCell")
        // 注册监听
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
        // 数据源
        self.sectionFetchResults.append(PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.SmartAlbum, subtype: PHAssetCollectionSubtype.AlbumRegular, options: nil)) // 智能相册
        self.sectionFetchResults.append(PHAssetCollection.fetchTopLevelUserCollectionsWithOptions(nil)) // 自定义相册
        self.reloadData() // 刷新
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.tabBar.hidden = true
    }
    
    deinit {
         PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
    }
    
    // MARK: - Action
    // MARK: 创建相薄
    func onClickAddCollectionList() {
        let alertController = UIAlertController(title: "新相薄", message: nil, preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = "相薄名"
        }
        alertController.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "创建", style: .Default, handler: { (action: UIAlertAction) -> Void in
            if let title = alertController.textFields?.first?.text {
                PHAssetCollection.creationWithTitle(title)
            }
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - 刷新数据
    func reloadData() {
        // 清空数据源
        self.data.removeAll()
        self.dataTitleForHeader.removeAll()
        self.dataFetchResults.removeAll()
        let sectionLocalizedTitles = ["系统相册", "自定义相册"] // 组标题
        var array = [YJPhotoAlbumsCellModel]() // 相薄集合
        let imageManager = PHImageManager.defaultManager() // 照片管理器
        let targetSize = CGSizeMake(70, 70) // 图片显示大小
        for (section, collectionList) in self.sectionFetchResults.enumerate() {
            array.removeAll()
            // 获取相薄
            collectionList.enumerateObjectsUsingBlock({ (obj: AnyObject, index: Int, umPointer: UnsafeMutablePointer<ObjCBool>) -> Void in
                guard let assetCollection = obj as? PHAssetCollection else {
                    return
                }
                // 相薄内的照片数量
                let phAssetFetchResult = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
                let cellModel = YJPhotoAlbumsCellModel()
                cellModel.assetCollection = assetCollection
                cellModel.text = assetCollection.localizedTitle
                cellModel.detailText = "\(phAssetFetchResult.count)"
                // 显示最后一张照片
                if let asset: PHAsset = phAssetFetchResult.lastObject as? PHAsset {
                    imageManager.requestImageForAsset(asset, targetSize: targetSize, contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: { (image: UIImage?, info: [NSObject : AnyObject]?) -> Void in
                        cellModel.image = image
                    })
                }
                array.append(cellModel)
            })
            // 组内有相薄
            if array.count > 0 {
                self.data.append(array)
                dataTitleForHeader.append(sectionLocalizedTitles[section])
            }
        }
        self.tableView.reloadData()
    }
    
    // MARK: - PHPhotoLibraryChangeObserver
    func photoLibraryDidChange(changeInstance: PHChange) {
        print(__FUNCTION__)
        var reload = false // 是否需要刷新
        // 遍历元素和所处的位置
        for (index, value) in self.sectionFetchResults.enumerate() {
            if let changeDetails = changeInstance.changeDetailsForFetchResult(value) {
                reload = true
                // 修改数据源
                self.sectionFetchResults[index] = changeDetails.fetchResultAfterChanges
            }
        }
        // 刷新UI
        if reload {
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? YJAssetCollectionVC {
            if let indexPath = sender as? NSIndexPath {
                vc.assectCollection = self.sectionFetchResults[indexPath.section][indexPath.row] as! PHAssetCollection
                if indexPath.section == 1 {
                    vc.allowAddPhoto() //允许增加照片
                }
            }
        }
    }
    
    // MARK: -  UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("photoCell") as! YJPhotoTableViewCell
        let cellModel = self.data[indexPath.section][indexPath.row]
        cell.photoImageView.image = cellModel.image
        cell.titleLabel.text = cellModel.text
        cell.countLabel.text = cellModel.detailText
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dataTitleForHeader[section]
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: 左滑出现的按钮
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        guard indexPath.section == 1 else {
            return []
        }
        // 删除
        let delete = UITableViewRowAction(style: .Destructive, title: "删除") { (action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
            let fetchResults = self.sectionFetchResults[indexPath.section]
            if let assetCollection = fetchResults[indexPath.row] as? PHAssetCollection {
                assetCollection.delete()
            }
        }
        // 改名
        let rename = UITableViewRowAction(style: .Normal, title: "改名") { (action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
            guard let assetCollection = self.sectionFetchResults[indexPath.section][indexPath.row] as? PHAssetCollection else {
                return
            }
            let alertController = UIAlertController(title: "修改相薄名", message: nil, preferredStyle: .Alert)
            alertController.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
                textField.placeholder = "相薄名"
            }
            alertController.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "修改", style: .Default, handler: { (action: UIAlertAction) -> Void in
                guard let title = alertController.textFields?.first?.text else {
                    return
                }
                assetCollection.renameLocalizedTitle(title)
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        return [delete, rename]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("AssetCollection", sender: indexPath)
    }

}
