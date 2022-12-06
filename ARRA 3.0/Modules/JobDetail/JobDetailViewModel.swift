//
//  JobDetailViewModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import Foundation

class JobDetailViewModel{
    var job:JobDetail!
    
    func dataValidation( jobStatusID: Int?=nil ) -> (Bool, String?) {
        
        switch jobStatusID ?? job.jobStatusID {
        case JobStatus.assign() :
            break
        case JobStatus.accept() :
            if job.timeline?.accepted == nil {
                return (false, "Please enter accept datetime")
            }
            break
        case JobStatus.startTravel() :
            if job.timeline?.startTravel?.datetime == nil {
                return (false, "Please enter start travel datetime")
            }
            else if (job.timeline?.startTravel?.coordinates?.lat ?? 0) == 0 {
                return (false, "Please enter Latitude of start travel")
            }
            else if (job.timeline?.startTravel?.coordinates?.lng ?? 0) == 0 {
                return (false, "Please enter Longtitude of start travel")
            }
            
        default: break
//        case JobStatus.checkIn() :
//            if job.timeline?.checkIn?.datetime == nil {
//                return (false, "please enter check in datetime")
//            }
//            else if (job.timeline?.checkIn?.coordinates?.lat ?? 0) == 0 {
//                return (false, "Please enter Latitude of check in")
//            }
//            else if (job.timeline?.checkIn?.coordinates?.lng ?? 0) == 0 {
//                return (false, "Please enter Longtitude of check in")
            }
            //            else if job.timeline?.checkIn?.distance == 0 {
            //                return (false, "Please enter distance of check in")
            //            }
            
//            break
            //    default:
            //        if job.timeline?.repair?.startRepair == nil {
            //            return (false, "Please select start repair")
            //        }
            //        else if job.timeline?.repair?.closeRepair == nil {
            //            return (false, "Please select close repair")
            //        }
            //        else if (job.timeline?.repair?.startRepair?.toTimestamp() ?? 0) >= (job.timeline?.repair?.closeRepair?.toTimestamp() ?? 0) {
            //            return (false, "Please check start repair and close repair")
            //        }
            //        else if !overSLAValidation() {
            //            return (false, "Please select Over SLA Reason")
            //        }
            //        else if job.recommendation == nil || job.recommendation == "" {
            //            return (false, "Please enter recommendation")
            //        }
            //        else if job.jobTechnicalSupport?.uniqueID == 9999 && job.jobTechnicalSupport?.remark == "" {
            //            return (false, "Please enter job technical support")
            //        }
            //
            //        break
            //    }
            //
            return (true, nil)
        }
    }

