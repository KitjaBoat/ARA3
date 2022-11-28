//
//  DeviceInfo.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import Foundation
import UIKit

class DeviceInfo{
    var deviceName: String?
    var os: String?
    var osVersion: String?
    var macAddress: String?
    
    func setupDevice() -> DeviceInfo {
        let device = UIDevice.current
        
        deviceName = device.name
        os = device.systemName
        osVersion = device.systemVersion
        macAddress = device.identifierForVendor?.description
        
        return self
    }
}
