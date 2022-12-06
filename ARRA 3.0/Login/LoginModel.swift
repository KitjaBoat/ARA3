//
//  LoginModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 29/11/2565 BE.
//

import Foundation
import UIKit

class RequestLogin:BaseModel  {
    var username: String?
    var password: String?
//    var deviceInfo: DeviceInfo?
    
    init(username:String,password:String?) {
        self.username = username
        self.password = password
        super.init()
//        self.deviceInfo = deviceInfo.setupDevice()
    }  
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class RequestBody:Codable {
    var module: String
    var target: String
    var data: BaseModel?
    var token: String?
    
//    
    init(
        module: String,
        target: String,
        data: BaseModel?=nil,
        noToken: Bool = false,
        token: String? = nil
    ) {
        self.module = module
        self.target = target
        self.data = data
        self.token = token ?? LoginResponse.current?.token
    }
    
     init(
        module: String,
        target: String,
        
//        noToken: Bool = false
        token: String?
    ) {
        self.module = module
        self.target = target
        
        self.token = token ?? LoginResponse.current?.token
    }
    
    init(
       module: String,
       target: String

   ) {
       self.module = module
       self.target = target
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

class BaseModel:Codable {
    
}

class RequestJobDetail: BaseModel {
    var jobID: Int = 0
}
