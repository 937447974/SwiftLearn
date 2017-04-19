//
//  YJAssetVC.swift
//  Photo
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/28.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

/// 照片或视频
class YJAssetVC: UIViewController, PHLivePhotoViewDelegate, PHPhotoLibraryChangeObserver {
    
    /// 相册
    var assetCollection: PHAssetCollection?
    /// 照片
    var asset: PHAsset!
    /// 照片
    @IBOutlet weak var imageView: UIImageView!
    /// 视频
    @IBOutlet weak var livePhotoView: PHLivePhotoView!
    /// 是否正在播放视频
    fileprivate var playing = false
    /// 播放视频
    fileprivate var playerLayer: AVPlayerLayer?;
    
    // MARK: - viewDid
    override func viewDidLoad() {
        super.viewDidLoad()
        self.livePhotoView.delegate = self
        self.reloadUI()
        PHPhotoLibrary.shared().register(self) // 监听照片库
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    // MARK: - PHPhotoLibraryChangeObserver
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        print(#function)
        let changeDetails = changeInstance.changeDetails(for: self.asset)
        if let assectCollection = changeDetails?.objectAfterChanges as? PHAsset {
            self.asset = assectCollection
            self.playerLayer = nil;
            if changeDetails!.assetContentChanged {
                DispatchQueue.main.async(execute: { () -> Void in
                    self.playerLayer?.removeFromSuperlayer()
                    self.playerLayer = nil;
                    self.reloadImage()
                })
            }
        }
    }
    
    // MARK: - reload
    // MARK: 刷新UI
    fileprivate func reloadUI() {
        self.navigationItem.title = self.asset.burstIdentifier
        self.reloadBarButtonItem()
        self.reloadImage()
        self.view.layoutIfNeeded()
    }
    
    // MARK: 刷新按钮
    fileprivate func reloadBarButtonItem() {
        var rightItems = [UIBarButtonItem]()
        // 能否播放
        if self.asset.mediaType == PHAssetMediaType.video {
            rightItems.append(UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(YJAssetVC.onClickPlay)))
        }
        // 能否删除
        if self.asset.canPerform(PHAssetEditOperation.delete) {
            rightItems.append(UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(YJAssetVC.onClickTrash)))
        }
        // 能否编辑
        if self.asset.canPerform(.properties) || self.asset.canPerform(.content) {
            rightItems.append(UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(YJAssetVC.onClickEdit(_:))))
        }
        self.navigationItem.rightBarButtonItems = rightItems
    }
    
    // MARK: 更新图片
    fileprivate func reloadImage() {
        if self.asset.mediaSubtypes == PHAssetMediaSubtype.photoLive {
            let options = PHLivePhotoRequestOptions()
            options.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
            options.isNetworkAccessAllowed = true
            options.progressHandler = { (progress: Double, error: Error?, stop: UnsafeMutablePointer<ObjCBool>, info: [AnyHashable: Any]?) -> Void in
                print(progress)
            }
            PHImageManager.default().requestLivePhoto(for: self.asset, targetSize: self.targetSize(), contentMode: PHImageContentMode.aspectFit, options: options, resultHandler: { (livePhoto: PHLivePhoto?, info: [AnyHashable: Any]?) -> Void in
                self.livePhotoView.livePhoto = livePhoto
                if let degradedKeyinfo = info?[PHImageResultIsDegradedKey] {
                    if !(degradedKeyinfo as AnyObject).boolValue && !self.playing {
                        self.livePhotoView.startPlayback(with: PHLivePhotoViewPlaybackStyle.hint)
                    }
                }
            })
        } else {
            let options = PHImageRequestOptions()
            options.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
            options.isNetworkAccessAllowed = true
            options.progressHandler = { (progress: Double, error: Error?, stop: UnsafeMutablePointer<ObjCBool>, info: [AnyHashable: Any]?) -> Void in
                print(progress)
            }
            PHImageManager.default().requestImage(for: self
                .asset, targetSize: self.targetSize(), contentMode: .aspectFit, options: options, resultHandler: { (image: UIImage?, info: [AnyHashable: Any]?) -> Void in
                    self.imageView.image = image
            })
        }
    }
    
    // MARK: 获取照片显示的尺寸
    func targetSize() -> CGSize {
        let scale = UIScreen.main.scale
        let targetSize = CGSize(width: self.view.bounds.width * scale,  height: self.view.bounds.height * scale)
        return targetSize
    }
    
    // MARK: - Action
    // MARK: 删除
    func onClickTrash() {
        self.asset.deleteWithPHAssetCollection(self.assetCollection) { (success: Bool, error: Error?) -> Void in
            if success {
                DispatchQueue.main.async(execute: { () -> Void in
                    self.navigationController?.popViewController(animated: true) // 删除成功回到上个界面
                })
            } else {
                print(error!)
            }
        }
    }
    
    // MARK: 编辑
    func onClickEdit(_ sender: AnyObject) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        // 是否收藏
        if self.asset.canPerform(.properties) {
            let favoriteActionTitle = self.asset.isFavorite ? "取消收藏" : "收藏"
            alertController.addAction(UIAlertAction(title: favoriteActionTitle, style: .default, handler: { (action: UIAlertAction) -> Void in
                self.asset.setFavorite(!self.asset.isFavorite)
            }))
        }
        //  PHAsset支持编辑内容，且是一张普通照片，不是一张生活照片
        if self.asset.canPerform(.content) && self.asset.mediaType == PHAssetMediaType.image && self.asset.mediaSubtypes != PHAssetMediaSubtype.photoLive {
            alertController.addAction(UIAlertAction(title: "深褐色", style: .default, handler: { (action: UIAlertAction) -> Void in
                self.applyFilterWithName("CISepiaTone")
            }))
            alertController.addAction(UIAlertAction(title: "浅褐色", style: .default, handler: { (action: UIAlertAction) -> Void in
                self.applyFilterWithName("CIPhotoEffectChrome")
            }))
            alertController.addAction(UIAlertAction(title: "恢复原始状态", style: .default, handler: { (action: UIAlertAction) -> Void in
                self.revertToOriginal()
            }))
        }
        // 取消按钮
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        if YJUtilUserInterfaceIdiom.isPad {
            alertController.modalPresentationStyle = UIModalPresentationStyle.popover
            alertController.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
            alertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: 播放
    func onClickPlay() {
        if self.livePhotoView.livePhoto != nil {
            self.livePhotoView .startPlayback(with: .full)
        } else if self.playerLayer != nil {
            self.playerLayer?.player?.play()
        } else {
            PHImageManager.default().requestAVAsset(forVideo: self.asset, options: nil, resultHandler: { (asset: AVAsset?, mix: AVAudioMix?, info: [AnyHashable: Any]?) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if self.playerLayer == nil && asset != nil {
                        let viewLayer = self.view.layer
                        let playItem = AVPlayerItem(asset: asset!)
                        playItem.audioMix = mix
                        let player = AVPlayer(playerItem: playItem)
                        let playerLayer = AVPlayerLayer(player: player)
                        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
                        playerLayer.frame = CGRect(x: 0, y: 0, width: viewLayer.bounds.size.width, height: viewLayer.bounds.size.height)
                        viewLayer.addSublayer(playerLayer)
                        player.play()
                        self.playerLayer = playerLayer;
                    }
                })
            })
        }
    }
    
    // MARK: - PHLivePhotoViewDelegate
    func livePhotoView(_ livePhotoView: PHLivePhotoView, willBeginPlaybackWith playbackStyle: PHLivePhotoViewPlaybackStyle) {
        print(#function)
        self.playing = true
    }
    
    func livePhotoView(_ livePhotoView: PHLivePhotoView, didEndPlaybackWith playbackStyle: PHLivePhotoViewPlaybackStyle) {
        print(#function)
        self.playing = false
    }
    
    // MARK: - Target Action Methods.
    // MARK: 恢复原始状态
    fileprivate func revertToOriginal() {
        let changeBlock: ()->() = {
            let request = PHAssetChangeRequest(for: self.asset)
            request.revertAssetContentToOriginal()
        }
        PHPhotoLibrary.shared().performChanges(changeBlock) { (success: Bool, error: Error?) -> Void in
            if !success {
                print(error!)
            }
        }
    }
    
    fileprivate func applyFilterWithName(_ filterName: String) {
        let options = PHContentEditingInputRequestOptions()
        options.canHandleAdjustmentData = { (adjustmentData: PHAdjustmentData) -> Bool in
            return adjustmentData.formatIdentifier == "com.Photo" && adjustmentData.formatVersion == "1.0"
        }
        self.asset.requestContentEditingInput(with: options) { (contentEditingInput: PHContentEditingInput?, info: [AnyHashable: Any]) -> Void in
            guard contentEditingInput != nil else {
                print("contentEditingInput 空")
                return
            }
            // Create a CIImage from the full image representation.
            let url = contentEditingInput!.fullSizeImageURL
            var inputImage = CIImage(contentsOf: url!)
            inputImage = inputImage?.applyingOrientation(contentEditingInput!.fullSizeImageOrientation)
            // Create the filter to apply.
            let filter = CIFilter(name: filterName)
            filter?.setDefaults()
            filter?.setValue(inputImage, forKey: kCIInputImageKey)
            // Apply the filter
            let outputImage = filter?.outputImage
            // Create a PHAdjustmentData object that describes the filter that was applied.
            let adjustmentData = PHAdjustmentData(formatIdentifier: "com.Photo", formatVersion: "1.0", data: filterName.data(using: String.Encoding.utf8)!)
            /*
            Create a PHContentEditingOutput object and write a JPEG representation of the filtered object to the renderedContentURL.
            */
            let contentEditingOutput = PHContentEditingOutput(contentEditingInput: contentEditingInput!)
            //
            let eaglContext = EAGLContext(api: EAGLRenderingAPI.openGLES2)
            let ciContext = CIContext(eaglContext: eaglContext!)
            let outputImageRef = ciContext.createCGImage(outputImage!, from: outputImage!.extent)
            let uiImage = UIImage(cgImage: outputImageRef!, scale: 1.0, orientation: .up)
            let jpegData = UIImageJPEGRepresentation(uiImage, 0.9);
            try? jpegData?.write(to: contentEditingOutput.renderedContentURL, options: [.atomic])
            contentEditingOutput.adjustmentData = adjustmentData
            // Ask the shared PHPhotoLinrary to perform the changes.
            let changeBlock: ()->() = {
                let request = PHAssetChangeRequest(for: self.asset)
                request.contentEditingOutput = contentEditingOutput;
            }
            PHPhotoLibrary.shared().performChanges(changeBlock) { (success: Bool, error: Error?) -> Void in
                if !success {
                    print(error!)
                }
            }
        }
    }
    
}
