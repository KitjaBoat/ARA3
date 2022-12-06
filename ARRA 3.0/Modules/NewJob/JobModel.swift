//
//  NewJobModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import Foundation


//struct JobMedel: Codable {
//    let status: Int
//    let message: String
//    let entries: [JobDetail]
//}
//
//// MARK: - Entry
//struct JobDetail: Codable {
//    let uniqueID: Int
//    let jobTitle, serialNO, problem, appearance: String
//    let contactRemark: String
//    let jobStatusID: Int
//    let timeline: Timeline
//    let customer: Customer
//    let warranty: Warranty
//    let engineer: [Engineer]
//    let jobProblem, jobSolution: Job
//    let jobTechnicalSupport: JobTechnicalSupport
//    let rejectedBy: String
//    let rejectedDate: Int
//    let rejectedReason: String
//    let partOfUse: [PartOfUse]
//    let attachment: [Attachment]
//    let recommendation: JSONNull?
//    let dispatcherRecommend: String
//    let updateDate: Int
//        let uniqueID: Int
//      let jobTitle, serialNO, problem, appearance: String
//      let contactRemark: String
//      let jobStatusID: Int
//      let timeline: Timeline
//      let customer: Customer
//      let warranty: Warranty
//      let engineer: [Engineer]
//      let jobProblem, jobSolution: Job
//      let jobTechnicalSupport: JobTechnicalSupport
//      let rejectedBy: String
//      let rejectedDate: Int
//      let rejectedReason: String
//      let partOfUse: [PartOfUse]
//      let attachment: [Attachment]
////      let recommendation: JSONNull?
//      let dispatcherRecommend: String
//      let updateDate: Int
//      let problemImage: [ProblemImage]?
//}

// MARK: - Attachment
struct Attachment: Codable {
    let uniqueID: Int
    let title: String
    let url: String
}

// MARK: - Customer
struct Customer: Codable {
    let name, tel: String
    let location: Location
}

// MARK: - Location
struct Location: Codable {
    let address: String
    let coordinates: Coordinates
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let lat, lng: Double
}

// MARK: - Engineer
struct Engineer: Codable {
    let uniqueID: Int
    let employeeID, name: String
    let accepted: Bool
    let isLead: Bool?
    let updateDate: Int
}

// MARK: - Job
struct Job: Codable {
    let uniqueID, subID: Int
    let remark: String
    
    

}

// MARK: - JobTechnicalSupport
struct JobTechnicalSupport: Codable {
    let uniqueID: Int
    let remark: String
}

// MARK: - PartOfUse
struct PartOfUse: Codable {
    let partID, quantity: Int
    let remark: String
}

// MARK: - Timeline
struct Timeline: Codable {
     var opened: Date?
     var condition: Condition?
     var assignment: Int?
     var accepted: Date?
     var appointment: Date?
     var startTravel: JobStamp?
//     var checkIn: JobStamp?
//     var repair: Repair?
//     var checkOut: JobS
}

// MARK: - Condition
struct Condition: Codable {
    let slaResponse, slaFixed: Int
}

// MARK: - Warranty
struct Warranty: Codable {
    let warrantyNo: String
    let expire, expireSupplier: Int
    let sparePart: SparePart?
}

// MARK: - SparePart
struct SparePart: Codable {
    let buffers, parts: [Buffer]
}

// MARK: - Buffer
struct Buffer: Codable {
    let uniqueID: Int
    let name: String
    let quantity, usage: Int
}


struct JobMedel
: Codable {
    let status: Int
    let message: String
    let entries: [JobDetail]
}

struct JobDetailModel
: Codable {
    let status: Int
    let message: String
    let entries: JobDetail
}

// MARK: - Entry
struct JobDetail: Codable {
    let uniqueID: Int?
    let jobTitle, serialNO, problem:String
    let appearance: String?
    let contactRemark: String?
    let jobStatusID: Int?
    let timeline: Timeline?
    let customer: Customer
    let warranty: Warranty?
    var engineer: [Engineer]?
    let jobProblem, jobSolution: Job?
    let jobTechnicalSupport: JobTechnicalSupport?
    let rejectedBy: String?
    let rejectedDate: Int?
    let rejectedReason: String?
    let partOfUse: [PartOfUse]?
    let attachment: [Attachment]?
    let dispatcherRecommend: String?
    var updateDate: Int?
    
    func getJobStatus() -> MJobStatus? {
        let statusList = MasterData.mJobStatus?.filter({ jobStatus in
            return jobStatus.uniqueID == jobStatusID
        })
        return statusList?.first
    }
  
}

class JobStamp : BaseModel {
    var coordinates: Coordinates?
    var distance: Float = 0 // Meter
    var datetime: Date?
    var jobProgressList: [JobProgress]?
   var repairList: [MRepair]?
}

class JobProgress : BaseModel {
    var jobProgressID: CLong = 0
   var detail: String?
     var datetime: Date?
    
//    func getJobProgress() -> MJobProgress? {
//        
//        let module = ModuleManager.getModule(key: NewJobModule.key) as? NewJobModule
//        let jobProgressList = module?.getMasterDataList( MJobProgress.self )?.filter({ ( jobProgress ) -> Bool in
//            return jobProgress.uniqueID == jobProgressID
//        })
//        
//        return jobProgressList?.first
//    }
}

class MRepair : BaseModel {
   var title: String?
}
