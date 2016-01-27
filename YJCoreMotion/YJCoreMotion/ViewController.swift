//
//  ViewController.swift
//  YJCoreMotion
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/26.
//  Copyright © 2016年 阳君. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    /// UITextView
    @IBOutlet weak var textView: UITextView!
    /// 队列
    private let queue = NSOperationQueue.mainQueue()
    /// 运动管理器
    private let motionManager = CMMotionManager()
    /// 刷新时间间隔
    private let timeInterval: NSTimeInterval = 0.2
    /// 加速计数据
    private var accelerometerDataText = "" { didSet { self.reloadUI() } }
    /// 螺旋仪数据
    private var gyroDataText = "" { didSet { self.reloadUI() } }
    /// 磁场计数据
    private var magnetometerDataText = "" { didSet { self.reloadUI() } }
    /// 步数计
    private let pedometer = CMPedometer()
    /// 步数计数据
    private var pedometerDataText = "" { didSet { self.reloadUI() } }
    /// 高度计
    private let altimeter = CMAltimeter()
    /// 高度计数据
    private var altitudeDataText = "" { didSet { self.reloadUI() } }
    /// 活动器
    private let motionActivityManager = CMMotionActivityManager()
    /// 活动数据
    private var motionActivityText = "" { didSet { self.reloadUI() } }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Action
    @IBAction func onClickSearch(sender: AnyObject) {
        self.onClickStop(sender)
        print("是否授权获取数据：\(CMSensorRecorder.isAuthorizedForRecording())")
        guard CMSensorRecorder.isAccelerometerRecordingAvailable() else {
            print("无法获取加速器历史数据")
            return
        }
        let recorder = CMSensorRecorder()
        recorder.recordAccelerometerFor(20 * 60)  // Record for 20 minutes
        // 一段时间的数据
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        if let oneDayAgo = calendar.dateByAddingUnit(NSCalendarUnit.Day, value: -1, toDate: now, options: NSCalendarOptions()) {
            let list = recorder.accelerometerDataFrom(oneDayAgo, to: now)
            print(list)
        }
    }
    
    // MARK: 开始获取数据
    @IBAction func onClickRefresh(sender: AnyObject) {
        self.startAccelerometerUpdates()
        self.startGyroUpdates()
        self.startMagnetometerUpdates()
        self.startPedometerUpdates()
        self.startRelativeAltitudeUpdates()
        self.startActivityUpdates()
    }
    
    // MARK: 停止获取数据
    @IBAction func onClickStop(sender: AnyObject) {
        self.motionManager.stopAccelerometerUpdates()
        self.motionManager.stopGyroUpdates()
        self.motionManager.stopMagnetometerUpdates()
        self.pedometer.stopPedometerUpdates()
        self.altimeter.stopRelativeAltitudeUpdates()
        self.motionActivityManager.stopActivityUpdates()
    }
    
    // MARK: - 加速计
    private func startAccelerometerUpdates() {
        guard self.motionManager.accelerometerAvailable else {
            self.accelerometerDataText = "\n设备不支持加速计\n"
            return
        }
        self.motionManager.accelerometerUpdateInterval = self.timeInterval // 刷新间隔
        self.motionManager.startAccelerometerUpdatesToQueue(self.queue) { (accelerometerData:CMAccelerometerData?, error: NSError?) -> Void in
            guard error == nil else {
                print(error)
                return
            }
            // 有更新
            if self.motionManager.accelerometerActive {
                var text = ""
                if let acceleration = accelerometerData?.acceleration {
                    text += "\n加速计\n"
                    text += "x: \(acceleration.x)G\n"
                    text += "y: \(acceleration.y)G\n"
                    text += "z: \(acceleration.z)G\n"
                }
                self.accelerometerDataText = text
            }
        }
    }
    
    // MARK: 螺旋仪
    private func startGyroUpdates() {
        guard self.motionManager.gyroAvailable else {
            self.gyroDataText = "\n设备不支持螺旋仪\n"
            return
        }
        self.motionManager.gyroUpdateInterval = self.timeInterval
        self.motionManager.startGyroUpdatesToQueue(queue) { (gyroData: CMGyroData?, error: NSError?) -> Void in
            guard error == nil else {
                print(error)
                return
            }
            // 有更新
            if self.motionManager.gyroActive {
                if let rotationRate = gyroData?.rotationRate {
                    var text = "\n螺旋计\n"
                    text += "x: \(rotationRate.x)\n"
                    text += "y: \(rotationRate.y)\n"
                    text += "z: \(rotationRate.z)\n"
                    self.gyroDataText = text
                }
            }
        }
    }
    
    // MARK: 磁场计
    private func startMagnetometerUpdates() {
        guard self.motionManager.magnetometerAvailable else {
            self.magnetometerDataText = "\n设备不支持磁场计\n"
            return
        }
        self.motionManager.magnetometerUpdateInterval = self.timeInterval
        self.motionManager.startMagnetometerUpdatesToQueue(queue) { (magnetometerData: CMMagnetometerData?, error: NSError?) -> Void in
            guard error == nil else {
                print(error)
                return
            }
            if self.motionManager.magnetometerActive {
                if let magneticField = magnetometerData?.magneticField {
                    var text = "\n磁场计\n"
                    text += "x: \(magneticField.x)\n"
                    text += "y: \(magneticField.y)\n"
                    text += "z: \(magneticField.z)\n"
                    self.magnetometerDataText = text
                }
            }
        }
    }
    
    // MARK: 步数计
    private func startPedometerUpdates() {
        guard CMPedometer.isStepCountingAvailable() else {
            self.pedometerDataText = "\n设备不支持获取步数\n"
            return
        }
        self.pedometer.startPedometerUpdatesFromDate(NSDate()) { (pedometerData: CMPedometerData?, error: NSError?) -> Void in
            guard error == nil else {
                print(error)
                return
            }
            var text = "\n步数计\n"
            if let numberOfSteps = pedometerData?.numberOfSteps {
                text += "步数: \(numberOfSteps)\n"
            }
            if let distance = pedometerData?.distance {
                text += "距离: \(distance)\n"
            }
            if let floorsAscended = pedometerData?.floorsAscended {
                text += "上楼: \(floorsAscended)\n"
            }
            if let floorsDescended = pedometerData?.floorsDescended {
                text += "下楼: \(floorsDescended)\n"
            }
            if let currentPace = pedometerData?.currentPace {
                text += "速度: \(currentPace)m/s\n"
            }
            if let currentCadence = pedometerData?.currentCadence {
                text += "速度: \(currentCadence)步/秒\n"
            }
            self.pedometerDataText = text
        }
    }
    
    // MARK: 高度计
    private func startRelativeAltitudeUpdates() {
        guard CMAltimeter.isRelativeAltitudeAvailable() else {
            self.altitudeDataText = "\n设备不支持获取高度\n"
            return
        }
        var altitude: Float = 0.0
        self.altimeter.startRelativeAltitudeUpdatesToQueue(self.queue) { (altitudeData: CMAltitudeData?, error: NSError?) -> Void in
            guard error == nil else {
                print(error)
                return
            }
            if altitudeData != nil {
                altitude += altitudeData!.relativeAltitude.floatValue
                var text = "\n高度计\n"
                text += "高度变化: \(altitude)米\n"
                text += "压力: \(altitudeData!.pressure)kPa\n"
                self.altitudeDataText = text
            }
        }
    }
    
    // MARK: 当前活动状态
    private func startActivityUpdates() {
        guard CMMotionActivityManager.isActivityAvailable() else {
            self.motionActivityText = "\n设备不支持获取用户所处环境\n"
            return
        }
        self.motionActivityManager.startActivityUpdatesToQueue(queue) { (mActivity: CMMotionActivity?) -> Void in
            if mActivity != nil {
                self.motionActivityText = "\n用户当前所处环境：\(mActivity!.motionActivity())\n"
            }
        }
    }
    
    // MARK: - 刷新UI
    private func reloadUI() {
        var text = self.accelerometerDataText + self.gyroDataText + self.magnetometerDataText
        text += self.pedometerDataText + self.altitudeDataText + self.motionActivityText
        self.textView.text = text
    }
    
}
