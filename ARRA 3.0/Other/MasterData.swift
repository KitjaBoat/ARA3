//
//  MasterData.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 2/12/2565 BE.
//

import Foundation
import UIKit

class MasterData {
    static var mJobStatus:[MJobStatus]?
}

// for apiCall
class MjobModel: Codable {
    let status: Int
    let message: String
    let entries: [MJobStatus]
}

class MJobStatus: Codable {
//    static var current:MJobStatus?
    
    let uniqueID: Int
    let detail: String
    let isActive: Bool
    let updateDate: Int
    
    
    func getStatus() -> JobStatus {
        return JobStatus.getStatus(uniqueID: uniqueID)
    }
    
    func getIcon() -> UIImage? {
        let jobStatus = getStatus()
        
        switch jobStatus {
        case .ASSIGN:
            return UIImage(named: "ic_status_assign")
        case .ACCEPT:
            return UIImage(named: "ic_status_accept")
        case .START_TRAVEL:
            return UIImage(named: "ic_status_progress")
        case .CHECK_IN:
            return UIImage(named: "ic_status_progress")
        case .DONE:
            return UIImage(named: "ic_status_finish")
        case .REWORK:
            return UIImage(named: "ic_status_rework")
        case .REWORK_UP:
            return UIImage(named: "ic_status_rework")
        case .REWORK_DOWN:
            return UIImage(named: "ic_status_rework")
        case .REJECT:
            return UIImage(named: "ic_status_rework")
        default:
            return nil
        }
    }
}


enum JobStatus : Int {
    case ASSIGN = 1
    case ACCEPT = 2
    case START_TRAVEL = 3
    case CHECK_IN = 4
    // CHECK OUT
    case DONE = 5
    case REWORK = 6
    case REWORK_UP = 7
    case REWORK_DOWN = 8
    // REJECT
    case REJECT = 9
    // NOT FOUND
    case NONE = 0
    
    static func getStatus( uniqueID: Int ) -> JobStatus {
        switch uniqueID {
        case assign():
            return .ASSIGN
        case accept():
            return .ACCEPT
        case startTravel():
            return .START_TRAVEL
        case checkIn():
            return .CHECK_IN
        case done():
            return .DONE
        case rework():
            return .REWORK
        case reworkUp():
            return .REWORK_UP
        case reworkDown():
            return .REWORK_DOWN
        case reject():
            return .REJECT
        default:
            return .NONE
        }
    }
    
    static func assign() -> Int {
        return 2
    }
    
    static func accept() -> Int {
            return 3
    }
    
    static func startTravel() -> Int {
        return 12
    }
    
    static func checkIn() -> Int {
        return 4
    }
    
    static func done() -> Int {
        return 15
    }
    
    static func rework() -> Int {
        return 16
        
    }
    
    static func reworkUp() -> Int {
        return 99
    }
    
    static func reworkDown() -> Int {
        return 98
    }
    
    static func reject() -> Int {
        return 13
    }
}
