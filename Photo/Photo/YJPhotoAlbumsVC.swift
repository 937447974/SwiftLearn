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

    /// 组内成员
    private var sectionFetchResults = [PHFetchResult]()
    /// tableView的Header标题
    private var dataTitleForHeader = [String]()
    /// tableView的数据源
    private var data = Array<Array<YJPhotoAlbumsCellModel>>()
    /// tableView数据源对应的PHAssetCollection集合
    private var dataFetchResults = [PHFetchResult]()
    /// tableView
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "onClickAddCollectionList")
        // 注册监听
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
        // 数据源
        self.sectionFetchResults.append(PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.SmartAlbum, subtype: PHAssetCollectionSubtype.AlbumRegular, options: nil)) // 智能相册
        self.sectionFetchResults.append(PHCollectionList.fetchTopLevelUserCollectionsWithOptions(nil)) // 专辑
        self.reloadData() // 刷新
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
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
                let changeBlock: dispatch_block_t = {
                    // 创建相薄
                    PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(title)
                }
                let completionHandler = { (success: Bool, error: NSError?) -> Void in
                    if !success {
                        print(error)
                    }
                }
                PHPhotoLibrary.sharedPhotoLibrary().performChanges(changeBlock, completionHandler: completionHandler)
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
        let sectionLocalizedTitles = ["智能相册", "专辑"] // 组标题
        var array = [YJPhotoAlbumsCellModel]() // 相薄集合
        let imageManager = PHCachingImageManager.defaultManager() // 照片管理器
        let targetSize = CGSizeMake(70, 70) // 图片显示大小
        for (section, collectionList) in self.sectionFetchResults.enumerate() {
            array.removeAll()
            // 确保每个相薄中都有照片，没照片的相薄不显示
            for row in 0..<collectionList.count {
                // 获取相薄
                if let assetCollection: PHAssetCollection = collectionList[row] as? PHAssetCollection {
                    // 相薄内的照片数量
                    let phAssetFetchResult = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
                    if phAssetFetchResult.count > 0 { // 大于0时显示
                        let cellModel = YJPhotoAlbumsCellModel()
                        cellModel.assetCollection = assetCollection
                        cellModel.text = assetCollection.localizedTitle
                        cellModel.detailText = "\(phAssetFetchResult.count)"
                        // 显示最后一张照片
                        let asset: PHAsset = phAssetFetchResult.lastObject as! PHAsset
                        imageManager.requestImageForAsset(asset, targetSize: targetSize, contentMode: PHImageContentMode.AspectFit, options: nil, resultHandler: { (image: UIImage?, info: [NSObject : AnyObject]?) -> Void in
                            cellModel.image = image
                        })
                        array.append(cellModel)
                    }
                }
            }
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
            self.reloadData()
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
        var cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "tableViewCell")
            cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell?.textLabel?.font = UIFont.systemFontOfSize(18)
        }
        let cellModel = self.data[indexPath.section][indexPath.row]
        cell?.imageView?.image = cellModel.image
        cell!.textLabel?.text = cellModel.text
        cell!.detailTextLabel?.text = cellModel.detailText
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dataTitleForHeader[section]
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
}
