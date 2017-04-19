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
    fileprivate var sectionFetchResults = [PHFetchResult<PHCollection>]()
    /// tableView的Header标题
    fileprivate var dataTitleForHeader = [String]()
    /// tableView的数据源
    fileprivate var data = Array<Array<YJPhotoAlbumsCellModel>>()
    /// tableView数据源对应的PHAssetCollection集合
    fileprivate var dataFetchResults = [PHFetchResult<AnyObject>]()
    
    // MARK: - viewDid
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(YJPhotoAlbumsVC.onClickAddCollectionList))
        // 注册cell
        let nib = UINib(nibName: YJPhotoTableViewCellNibName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "photoCell")
        // 注册监听
        PHPhotoLibrary.shared().register(self)
        // 数据源
        self.sectionFetchResults.append(PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.albumRegular, options: nil) as! PHFetchResult<PHCollection>) // 智能相册
        self.sectionFetchResults.append(PHAssetCollection.fetchTopLevelUserCollections(with: nil)) // 自定义相册
        self.reloadData() // 刷新
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    deinit {
         PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    // MARK: - Action
    // MARK: 创建相薄
    func onClickAddCollectionList() {
        let alertController = UIAlertController(title: "新相薄", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField: UITextField) -> Void in
            textField.placeholder = "相薄名"
        }
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "创建", style: .default, handler: { (action: UIAlertAction) -> Void in
            if let title = alertController.textFields?.first?.text {
                PHAssetCollection.creationWithTitle(title)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - 刷新数据
    func reloadData() {
        // 清空数据源
        self.data.removeAll()
        self.dataTitleForHeader.removeAll()
        self.dataFetchResults.removeAll()
        let sectionLocalizedTitles = ["系统相册", "自定义相册"] // 组标题
        var array = [YJPhotoAlbumsCellModel]() // 相薄集合
        let imageManager = PHImageManager.default() // 照片管理器
        let targetSize = CGSize(width: 70, height: 70) // 图片显示大小
        for (section, collectionList) in self.sectionFetchResults.enumerated() {
            array.removeAll()
            // 获取相薄
            collectionList.enumerateObjects({ (obj: AnyObject, index: Int, umPointer: UnsafeMutablePointer<ObjCBool>) -> Void in
                guard let assetCollection = obj as? PHAssetCollection else {
                    return
                }
                // 相薄内的照片数量
                let phAssetFetchResult = PHAsset.fetchAssets(in: assetCollection, options: nil)
                let cellModel = YJPhotoAlbumsCellModel()
                cellModel.assetCollection = assetCollection
                cellModel.text = assetCollection.localizedTitle
                cellModel.detailText = "\(phAssetFetchResult.count)"
                // 显示最后一张照片
                if let asset: PHAsset = phAssetFetchResult.lastObject {
                    imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: PHImageContentMode.aspectFill, options: nil, resultHandler: { (image: UIImage?, info: [AnyHashable: Any]?) -> Void in
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
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        print(#function)
        var reload = false // 是否需要刷新
        // 遍历元素和所处的位置
        for (index, value) in self.sectionFetchResults.enumerated() {
            if let changeDetails = changeInstance.changeDetails(for: value) {
                reload = true
                // 修改数据源
                self.sectionFetchResults[index] = changeDetails.fetchResultAfterChanges
            }
        }
        // 刷新UI
        if reload {
            DispatchQueue.main.async { () -> Void in
                self.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? YJAssetCollectionVC {
            if let indexPath = sender as? IndexPath {
                vc.assectCollection = self.sectionFetchResults[indexPath.section][indexPath.row] as! PHAssetCollection
                if indexPath.section == 1 {
                    vc.allowAddPhoto() //允许增加照片
                }
            }
        }
    }
    
    // MARK: -  UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell") as! YJPhotoTableViewCell
        let cellModel = self.data[indexPath.section][indexPath.row]
        cell.photoImageView.image = cellModel.image
        cell.titleLabel.text = cellModel.text
        cell.countLabel.text = cellModel.detailText
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dataTitleForHeader[section]
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: 左滑出现的按钮
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard indexPath.section == 1 else {
            return []
        }
        // 删除
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "删除") { (action: UITableViewRowAction, indexPath: IndexPath) -> Void in
            let fetchResults = self.sectionFetchResults[indexPath.section]
            if let assetCollection = fetchResults[indexPath.row] as? PHAssetCollection {
                assetCollection.deletes()
            }
        }
        // 改名
        let rename = UITableViewRowAction(style: .normal, title: "改名") { (action: UITableViewRowAction, indexPath: IndexPath) -> Void in
            guard let assetCollection = self.sectionFetchResults[indexPath.section][indexPath.row] as? PHAssetCollection else {
                return
            }
            let alertController = UIAlertController(title: "修改相薄名", message: nil, preferredStyle: .alert)
            alertController.addTextField { (textField: UITextField) -> Void in
                textField.placeholder = "相薄名"
            }
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "修改", style: .default, handler: { (action: UIAlertAction) -> Void in
                guard let title = alertController.textFields?.first?.text else {
                    return
                }
                assetCollection.renameLocalizedTitle(title)
            }))
            self.present(alertController, animated: true, completion: nil)
        }
        return [delete, rename]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "AssetCollection", sender: indexPath)
    }

}
