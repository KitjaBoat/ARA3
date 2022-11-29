//
//  User.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 29/11/2565 BE.
//

import Foundation

class User:Codable {
     var userID: String?
     var name: String?
     var businessUnit: [BusinessUnit]?
     var config: Config?
     var email: String?
     var imageURL: String?
     var permission: [String]?
     var requireCamera: Bool?
     var autoApproval: Bool?
    
    var role: String?
    //    @objc var roleID​: CLong = 0
    
    func getRepairImageLimit() -> Int {
        return self.config?.repairImageLimit ?? 5
    }

    func getDurationUpdateLocation() -> TimeInterval {
        return TimeInterval(5.minutes)
    }
}


