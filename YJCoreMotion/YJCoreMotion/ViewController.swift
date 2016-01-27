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
    private var accelerometerData: CMAccelerometerData? { didSet { self.reloadUI() } }
    /// 螺旋仪数据
    private var gyroData: CMGyroData? { didSet { self.reloadUI() } }
    /// 磁场计数据
    private var magnetometerData: CMMagnetometerData? { didSet { self.reloadUI() } }
    /// 步数计
    private let pedometer = CMPedometer()
    /// 布数计数据
    private var pedometerData: CMPedometerData? { didSet { self.reloadUI() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Action
    @IBAction func onClickSearch(sender: AnyObject) {
        
    }
    
    // MARK: 开始获取数据
    @IBAction func onClickRefresh(sender: AnyObject) {
        self.startAccelerometerUpdates()
        self.startGyroUpdates()
        self.startMagnetometerUpdates()
        self.startPedometerUpdates()
    }
    
    // MARK: 停止获取数据
    @IBAction func onClickStop(sender: AnyObject) {
        self.motionManager.stopAccelerometerUpdates()
        self.motionManager.stopGyroUpdates()
        self.motionManager.stopMagnetometerUpdates()
        self.pedometer.stopPedometerUpdates()
    }
    
    // MARK: - 加速计
    private func startAccelerometerUpdates() {
        guard self.motionManager.accelerometerAvailable else {
            print("设备不支持加速计")
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
                self.accelerometerData = accelerometerData
            }
        }
    }
    
    // MARK: 螺旋仪
    private func startGyroUpdates() {
        guard self.motionManager.gyroAvailable else {
            print("设备不支持螺旋仪")
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
                self.gyroData = gyroData
            }
        }
    }
    
    // MARK: 磁场计
    private func startMagnetometerUpdates() {
        guard self.motionManager.magnetometerAvailable else {
            print("设备不支持磁场计")
            return
        }
        self.motionManager.magnetometerUpdateInterval = self.timeInterval
        self.motionManager.startMagnetometerUpdatesToQueue(queue) { (magnetometerData: CMMagnetometerData?, error: NSError?) -> Void in
            guard error == nil else {
                print(error)
                return
            }
            if self.motionManager.magnetometerActive {
                self.magnetometerData = magnetometerData
            }
        }
    }
    
    // MARK: 步数计
    private func startPedometerUpdates() {
        guard CMPedometer.isStepCountingAvailable() else {
            print("设备不支持获取步数")
            return
        }
        self.pedometer.startPedometerUpdatesFromDate(NSDate()) { (pedometerData: CMPedometerData?, error: NSError?) -> Void in
            guard error == nil else {
                print(error)
                return
            }
            self.pedometerData = pedometerData
        }
    }

    // MARK: - 刷新UI
    private func reloadUI() {
        var text = ""
        if let acceleration = self.accelerometerData?.acceleration {
            text += "\n加速计\n"
            text += "x: \(acceleration.x)G\n"
            text += "y: \(acceleration.y)G\n"
            text += "z: \(acceleration.z)G\n"
        }
        if let rotationRate = self.gyroData?.rotationRate {
            text += "\n螺旋计\n"
            text += "x: \(rotationRate.x)\n"
            text += "y: \(rotationRate.y)\n"
            text += "z: \(rotationRate.z)\n"
        }
        if let magneticField = self.magnetometerData?.magneticField {
            text += "\n磁场计\n"
            text += "x: \(magneticField.x)\n"
            text += "y: \(magneticField.y)\n"
            text += "z: \(magneticField.z)\n"
        }
        if CMPedometer.isStepCountingAvailable() {
            text += "\n步数计\n"
            if let numberOfSteps = self.pedometerData?.numberOfSteps {
                text += "步数: \(numberOfSteps)\n"
            }
            if let distance = self.pedometerData?.distance {
                text += "距离: \(distance)\n"
            }
            if let floorsAscended = self.pedometerData?.floorsAscended {
                text += "上楼: \(floorsAscended)\n"
            }
            if let floorsDescended = self.pedometerData?.floorsDescended {
                text += "下楼: \(floorsDescended)\n"
            }
            if let currentPace = self.pedometerData?.currentPace {
                text += "速度: \(currentPace)m/s\n"
            }
            if let currentCadence = self.pedometerData?.currentCadence {
                text += "速度: \(currentCadence)步/秒\n"
            }
        }
        self.textView.text = text
    }

    

}




