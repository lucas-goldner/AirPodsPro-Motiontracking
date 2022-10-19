//
//  MotionTracker.swift
//  AirPod Tracking Demo
//
//  Created by Lucas Goldner on 19.10.22.
//

import Foundation
import CoreMotion

class MotionTracker: NSObject, ObservableObject {
    let airpods = CMHeadphoneMotionManager()
    @Published var infos: String
    @Published var isAvailable: Bool
    @Published var errorMessage: String
    
    override init() {
        infos = ""
        errorMessage = ""
        isAvailable = false
        super.init()
        airpods.delegate = self
        
        guard airpods.isDeviceMotionAvailable else {
            errorMessage = "Sorry, Your device is not supported."
            return
        }
        
        airpods.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {[weak self] motion, error  in
            guard let motion = motion, error == nil else { return }
            print(motion)
            self?.isAvailable = true
            self?.printData(motion)
        })
        
    }
    
    func printData(_ data: CMDeviceMotion) {
        infos = """
               Quaternion:
                   x: \(data.attitude.quaternion.x)
                   y: \(data.attitude.quaternion.y)
                   z: \(data.attitude.quaternion.z)
                   w: \(data.attitude.quaternion.w)
               Attitude:
                   pitch: \(data.attitude.pitch)
                   roll: \(data.attitude.roll)
                   yaw: \(data.attitude.yaw)
               Gravitational Acceleration:
                   x: \(data.gravity.x)
                   y: \(data.gravity.y)
                   z: \(data.gravity.z)
               Rotation Rate:
                   x: \(data.rotationRate.x)
                   y: \(data.rotationRate.y)
                   z: \(data.rotationRate.z)
               Acceleration:
                   x: \(data.userAcceleration.x)
                   y: \(data.userAcceleration.y)
                   z: \(data.userAcceleration.z)
               Magnetic Field:
                   field: \(data.magneticField.field)
                   accuracy: \(data.magneticField.accuracy)
               Heading:
                   \(data.heading)
               """
    }
}

extension MotionTracker: CMHeadphoneMotionManagerDelegate {
    func headphoneMotionManagerDidConnect(_ manager: CMHeadphoneMotionManager) {
        print("connect")
    }
    
    func headphoneMotionManagerDidDisconnect(_ manager: CMHeadphoneMotionManager) {
        print("disconnect")
    }
}
