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
    private var playing = false
    /// 播放视频
    private var playerLayer: AVPlayerLayer?;
    
    // MARK: - viewDid
    override func viewDidLoad() {
        super.viewDidLoad()
        self.livePhotoView.delegate = self
        self.reloadUI()
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self) // 监听照片库
    }
    
    deinit {
        PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
    }
    
    // MARK: - PHPhotoLibraryChangeObserver
    func photoLibraryDidChange(changeInstance: PHChange) {
        print(__FUNCTION__)
        let changeDetails = changeInstance.changeDetailsForObject(self.asset)
        if let assectCollection = changeDetails?.objectAfterChanges as? PHAsset {
            self.asset = assectCollection
            self.playerLayer = nil;
            if changeDetails!.assetContentChanged {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.playerLayer?.removeFromSuperlayer()
                    self.playerLayer = nil;
                    self.reloadImage()
                })
            }
        }
    }
    
    // MARK: - reload
    // MARK: 刷新UI
    private func reloadUI() {
        self.navigationItem.title = self.asset.burstIdentifier
        self.reloadBarButtonItem()
        self.reloadImage()
        self.view.layoutIfNeeded()
    }
    
    // MARK: 刷新按钮
    private func reloadBarButtonItem() {
        var rightItems = [UIBarButtonItem]()
        // 能否播放
        if self.asset.mediaType == PHAssetMediaType.Video {
            rightItems.append(UIBarButtonItem(barButtonSystemItem: .Play, target: self, action: "onClickPlay"))
        }
        // 能否删除
        if self.asset.canPerformEditOperation(PHAssetEditOperation.Delete) {
            rightItems.append(UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "onClickTrash"))
        }
        // 能否编辑
        if self.asset.canPerformEditOperation(.Properties) || self.asset.canPerformEditOperation(.Content) {
            rightItems.append(UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "onClickEdit:"))
        }
        self.navigationItem.rightBarButtonItems = rightItems
    }
    
    // MARK: 更新图片
    private func reloadImage() {
        if self.asset.mediaSubtypes == PHAssetMediaSubtype.PhotoLive {
            let options = PHLivePhotoRequestOptions()
            options.deliveryMode = PHImageRequestOptionsDeliveryMode.HighQualityFormat
            options.networkAccessAllowed = true
            options.progressHandler = { (progress: Double, error: NSError?, stop: UnsafeMutablePointer<ObjCBool>, info: [NSObject : AnyObject]?) -> Void in
                print(progress)
            }
            PHImageManager.defaultManager().requestLivePhotoForAsset(self.asset, targetSize: self.targetSize(), contentMode: PHImageContentMode.AspectFit, options: options, resultHandler: { (livePhoto: PHLivePhoto?, info: [NSObject : AnyObject]?) -> Void in
                self.livePhotoView.livePhoto = livePhoto
                if let degradedKeyinfo = info?[PHImageResultIsDegradedKey] {
                    if !degradedKeyinfo.boolValue && !self.playing {
                        self.livePhotoView.startPlaybackWithStyle(PHLivePhotoViewPlaybackStyle.Hint)
                    }
                }
            })
        } else {
            let options = PHImageRequestOptions()
            options.deliveryMode = PHImageRequestOptionsDeliveryMode.HighQualityFormat
            options.networkAccessAllowed = true
            options.progressHandler = { (progress: Double, error: NSError?, stop: UnsafeMutablePointer<ObjCBool>, info: [NSObject : AnyObject]?) -> Void in
                print(progress)
            }
            PHImageManager.defaultManager().requestImageForAsset(self
                .asset, targetSize: self.targetSize(), contentMode: .AspectFit, options: options, resultHandler: { (image: UIImage?, info: [NSObject : AnyObject]?) -> Void in
                    self.imageView.image = image
            })
        }
    }
    
    // MARK: 获取照片显示的尺寸
    func targetSize() -> CGSize {
        let scale = UIScreen.mainScreen().scale
        let targetSize = CGSizeMake(CGRectGetWidth(self.view.bounds) * scale,  CGRectGetHeight(self.view.bounds) * scale)
        return targetSize
    }
    
    // MARK: - Action
    // MARK: 删除
    func onClickTrash() {
        self.asset.deleteWithPHAssetCollection(self.assetCollection) { (success: Bool, error: NSError?) -> Void in
            if success {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.navigationController?.popViewControllerAnimated(true) // 删除成功回到上个界面
                })
            } else {
                print(error)
            }
        }
    }
    
    // MARK: 编辑
    func onClickEdit(sender: AnyObject) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        // 是否收藏
        if self.asset.canPerformEditOperation(.Properties) {
            let favoriteActionTitle = self.asset.favorite ? "取消收藏" : "收藏"
            alertController.addAction(UIAlertAction(title: favoriteActionTitle, style: .Default, handler: { (action: UIAlertAction) -> Void in
                self.asset.setFavorite(!self.asset.favorite)
            }))
        }
        //  PHAsset支持编辑内容，且是一张普通照片，不是一张生活照片
        if self.asset.canPerformEditOperation(.Content) && self.asset.mediaType == PHAssetMediaType.Image && self.asset.mediaSubtypes != PHAssetMediaSubtype.PhotoLive {
            alertController.addAction(UIAlertAction(title: "深褐色", style: .Default, handler: { (action: UIAlertAction) -> Void in
                self.applyFilterWithName("CISepiaTone")
            }))
            alertController.addAction(UIAlertAction(title: "浅褐色", style: .Default, handler: { (action: UIAlertAction) -> Void in
                self.applyFilterWithName("CIPhotoEffectChrome")
            }))
            alertController.addAction(UIAlertAction(title: "恢复原始状态", style: .Default, handler: { (action: UIAlertAction) -> Void in
                self.revertToOriginal()
            }))
        }
        // 取消按钮
        alertController.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
        if YJUtilUserInterfaceIdiom.isPad {
            alertController.modalPresentationStyle = UIModalPresentationStyle.Popover
            alertController.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
            alertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Up
        }
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: 播放
    func onClickPlay() {
        if self.livePhotoView.livePhoto != nil {
            self.livePhotoView .startPlaybackWithStyle(.Full)
        } else if self.playerLayer != nil {
            self.playerLayer?.player?.play()
        } else {
            PHImageManager.defaultManager().requestAVAssetForVideo(self.asset, options: nil, resultHandler: { (asset: AVAsset?, mix: AVAudioMix?, info: [NSObject : AnyObject]?) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if self.playerLayer == nil && asset != nil {
                        let viewLayer = self.view.layer
                        let playItem = AVPlayerItem(asset: asset!)
                        playItem.audioMix = mix
                        let player = AVPlayer(playerItem: playItem)
                        let playerLayer = AVPlayerLayer(player: player)
                        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
                        playerLayer.frame = CGRectMake(0, 0, viewLayer.bounds.size.width, viewLayer.bounds.size.height)
                        viewLayer.addSublayer(playerLayer)
                        player.play()
                        self.playerLayer = playerLayer;
                    }
                })
            })
        }
    }
    
    // MARK: - PHLivePhotoViewDelegate
    func livePhotoView(livePhotoView: PHLivePhotoView, willBeginPlaybackWithStyle playbackStyle: PHLivePhotoViewPlaybackStyle) {
        print(__FUNCTION__)
        self.playing = true
    }
    
    func livePhotoView(livePhotoView: PHLivePhotoView, didEndPlaybackWithStyle playbackStyle: PHLivePhotoViewPlaybackStyle) {
        print(__FUNCTION__)
        self.playing = false
    }
    
    // MARK: - Target Action Methods.
    // MARK: 恢复原始状态
    private func revertToOriginal() {
        let changeBlock: dispatch_block_t = {
            let request = PHAssetChangeRequest(forAsset: self.asset)
            request.revertAssetContentToOriginal()
        }
        PHPhotoLibrary.sharedPhotoLibrary().performChanges(changeBlock) { (success: Bool, error: NSError?) -> Void in
            if !success {
                print(error)
            }
        }
    }
    
    private func applyFilterWithName(filterName: String) {
        let options = PHContentEditingInputRequestOptions()
        options.canHandleAdjustmentData = { (adjustmentData: PHAdjustmentData) -> Bool in
            return adjustmentData.formatIdentifier == "com.Photo" && adjustmentData.formatVersion == "1.0"
        }
        self.asset.requestContentEditingInputWithOptions(options) { (contentEditingInput: PHContentEditingInput?, info: [NSObject : AnyObject]) -> Void in
            guard contentEditingInput != nil else {
                print("contentEditingInput 空")
                return
            }
            // Create a CIImage from the full image representation.
            let url = contentEditingInput!.fullSizeImageURL
            var inputImage = CIImage(contentsOfURL: url!)
            inputImage = inputImage?.imageByApplyingOrientation(contentEditingInput!.fullSizeImageOrientation)
            // Create the filter to apply.
            let filter = CIFilter(name: filterName)
            filter?.setDefaults()
            filter?.setValue(inputImage, forKey: kCIInputImageKey)
            // Apply the filter
            let outputImage = filter?.outputImage
            // Create a PHAdjustmentData object that describes the filter that was applied.
            let adjustmentData = PHAdjustmentData(formatIdentifier: "com.Photo", formatVersion: "1.0", data: filterName.dataUsingEncoding(NSUTF8StringEncoding)!)
            /*
            Create a PHContentEditingOutput object and write a JPEG representation of the filtered object to the renderedContentURL.
            */
            let contentEditingOutput = PHContentEditingOutput(contentEditingInput: contentEditingInput!)
            //
            let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            let ciContext = CIContext(EAGLContext: eaglContext)
            let outputImageRef = ciContext.createCGImage(outputImage!, fromRect: outputImage!.extent)
            let uiImage = UIImage(CGImage: outputImageRef, scale: 1.0, orientation: .Up)
            let jpegData = UIImageJPEGRepresentation(uiImage, 0.9);
            jpegData?.writeToURL(contentEditingOutput.renderedContentURL, atomically: true)
            contentEditingOutput.adjustmentData = adjustmentData
            // Ask the shared PHPhotoLinrary to perform the changes.
            let changeBlock: dispatch_block_t = {
                let request = PHAssetChangeRequest(forAsset: self.asset)
                request.contentEditingOutput = contentEditingOutput;
            }
            PHPhotoLibrary.sharedPhotoLibrary().performChanges(changeBlock) { (success: Bool, error: NSError?) -> Void in
                if !success {
                    print(error)
                }
            }
        }
    }
    
}
