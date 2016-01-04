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
class YJAssetVC: UIViewController, PHLivePhotoViewDelegate {
    
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
            rightItems.append(UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "onClickEdit"))
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
    func onClickEdit() {
        
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

}
