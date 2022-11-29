//
//  LoginModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 29/11/2565 BE.
//

import Foundation
import UIKit

class RequestLogin:Codable  {
    var username: String?
    var password: String?
//    var deviceInfo: DeviceInfo?
    
    init(username:String,password:String?) {
        self.username = username
        self.password = password
//        self.deviceInfo = deviceInfo.setupDevice()
    }  
}

class RequestBody:Codable {
    var module: String
    var target: String
    var data: RequestLogin
//    var token: String?
//    
    init(
        module: String,
        target: String,
        data: RequestLogin?
//        noToken: Bool = false
//        token: String? = nil
    ) {
        
        self.module = module
        self.target = target
        self.data = data ?? RequestLogin(username: "", password: "")
//        self.token = token ?? LoginResponse.current?.token
    }
}






class DeviceInfo {
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
