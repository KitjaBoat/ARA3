//
//  HomeViewModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import Foundation

class HomeViewModel {
//    let urlData =  "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/NewASale/12_Home/NotificationCount/data.json"
    let newJobUrl =  "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/2_NewJob/Data/Data/data.json"
    let jobListUrl = "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/3_JobList/Data/Data/data.json"
    
    
    //master
    let MJobStatusUrl = "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/2_NewJob/MasterData/MJobStatus/data.json"
    
    
    
    func loadJobData(module:String ,compltion:@escaping([JobDetail]) -> Void) {
        print("Thsi is module \(module)")
        var urlString:String?
        
        if module == Module.NewJob.rawValue {
            urlString = newJobUrl
        }
        else if module == Module.JobList.rawValue {
            urlString = jobListUrl
        }else {
            urlString = "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/13_RejectHistory/Data/JobRejectList/data.json"
        }
        let url = URL(string: urlString!)
        
        guard let url = url else {
            return
        }
        
        let reqBody = RequestBody(module: "NewJob",
                                  target: "JobList",
                                  data: nil)
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(reqBody)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if httpResponse.statusCode == 200 {
                    do {
                        let decode =
                        try JSONDecoder().decode(JobMedel.self, from: data)
                        if decode.status == 200 {
                            compltion(decode.entries)
                        }
                    } catch  {
                        print("errorDecode")
                    }
                }
                else {
                    print("errorStatusCode \(httpResponse.statusCode)")
                }
            }
        }
        task.resume()
    }
    
    func loadMasterData() {
            let url = URL(string: MJobStatusUrl)
            
            guard let url = url else {
                return
            }
            
            let reqBody = RequestBody(module: "NewJob",
                                      target: "MJobStatus",
                                      token: LoginResponse.current?.token)
            
            let jsonEncoder = JSONEncoder()
            let jsonData = try? jsonEncoder.encode(reqBody)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if httpResponse.statusCode == 200 {
                        do {
                            let decode =
                            try JSONDecoder().decode(MjobModel.self, from: data)
                            if decode.status == 200 {
                                MasterData.mJobStatus = decode.entries
                                print(decode.entries)
                            }
                        } catch  {
                            print("errorDecode")
                        }
                    }
                    else {
                        print("errorStatusCode \(httpResponse.statusCode)")
                    }
                }
            }
            task.resume()
        }
}


//static let masterData = [
//    BaseMasterData(
//        module: NewJobModule.key,
//        target: "MJobStatus",
//        URL: MOCK_DATA ?  "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/2_NewJob/MasterData/MJobStatus/data.json" : LoginResponse.getCache()?.getWebAPI(WebAPIKey.SELECT),
//        requestBody: RequestBody(module: NewJobModule.key, target: "MJobStatus")
//    ),
//    BaseMasterData(
//        module: NewJobModule.key,
//        target: "MOverSLAReason",
//        URL: MOCK_DATA ? "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/2_NewJob/MasterData/MOverSLAReason/data.json": LoginResponse.getCache()?.getWebAPI(WebAPIKey.SELECT),
//        requestBody: RequestBody(module: NewJobModule.key, target: "MOverSLAReason")
//    ),
//    BaseMasterData(
//        module: JobListModule.key,
//        target: "MJobProgress",
//        URL: MOCK_DATA ? "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/3_JobList/MasterData/MJobProgress/data.json": LoginResponse.getCache()?.getWebAPI(WebAPIKey.SELECT),
//        requestBody: RequestBody(module: JobListModule.key, target: "MJobProgress")
//    ),
//    BaseMasterData(
//        module: JobListModule.key,
//        target: "MRepair",
//        URL: MOCK_DATA ? "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/3_JobList/MasterData/MRepair/data.json": LoginResponse.getCache()?.getWebAPI(WebAPIKey.SELECT),
//        requestBody: RequestBody(module: JobListModule.key, target: "MRepair")
//    ),
//
//    // New update
//    BaseMasterData(
//        module: JobListModule.key,
//        target: "MJobProblem",
//        URL: MOCK_DATA ? "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/3_JobList/MasterData/MJobProblem/data.json": LoginResponse.getCache()?.getWebAPI(WebAPIKey.SELECT),
//        requestBody: RequestBody(module: JobListModule.key, target: "MJobProblem")
//    ),
//    BaseMasterData(
//        module: JobListModule.key,
//        target: "MJobSubProblem",
//        URL: MOCK_DATA ? "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/3_JobList/MasterData/MJobSubProblem/data.json": LoginResponse.getCache()?.getWebAPI(WebAPIKey.SELECT),
//        requestBody: RequestBody(module: JobListModule.key, target: "MJobSubProblem")
//    ),
//    BaseMasterData(
//        module: JobListModule.key,
//        target: "MJobSolution",
//        URL: MOCK_DATA ? "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/3_JobList/MasterData/MJobSolution/data.json": LoginResponse.getCache()?.getWebAPI(WebAPIKey.SELECT),
//        requestBody: RequestBody(module: JobListModule.key, target: "MJobSolution")
//    ),
//    BaseMasterData(
//        module: JobListModule.key,
//        target: "MJobSubSolution",
//        URL: MOCK_DATA ? "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/3_JobList/MasterData/MJobSubSolution/data.json": LoginResponse.getCache()?.getWebAPI(WebAPIKey.SELECT),
//        requestBody: RequestBody(module: JobListModule.key, target: "MJobSubSolution")
//    ),
//    BaseMasterData(
//        module: JobListModule.key,
//        target: "MJobTechnicalSupport",
//        URL: MOCK_DATA ? "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/3_JobList/MasterData/MJobTechnicalSupport/data.json": LoginResponse.getCache()?.getWebAPI(WebAPIKey.SELECT),
//        requestBody: RequestBody(module: JobListModule.key, target: "MJobTechnicalSupport")
//    ),
//    BaseMasterData(
//        module: JobListModule.key,
//        target: "MPartOfUse",
//        URL: MOCK_DATA ? "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/3_JobList/MasterData/MPartOfUse/data.json": LoginResponse.getCache()?.getWebAPI(WebAPIKey.SELECT),
//        requestBody: RequestBody(module: JobListModule.key, target: "MPartOfUse")
//    )
//]
