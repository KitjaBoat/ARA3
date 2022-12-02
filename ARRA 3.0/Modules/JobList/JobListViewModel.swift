//
//  JobListViewModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 1/12/2565 BE.
//

import Foundation

class JobListViewModel {
    
    let URL_LOAD_DATA = "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/3_JobList/Data/Data/data.json"
    let URL_LOAD_DATA_DTAIL =  "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/3_JobList/Data/JobDetail/data.json"
    
//    var jobList: [JobDetail]?
    
    
    func loadJobData(compltion:@escaping([JobDetail]) -> Void) {
        let url = URL(string: URL_LOAD_DATA)
        guard let url = url else {
            return
        }
        
        let reqBody = RequestBody(module: Module.JobList.rawValue,
                                  target: Module.JobList.rawValue)
       
        
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
    
    func loadJobDetailData(jobDetailId:Int,compltion:@escaping(JobDetail) -> Void) {
        let url = URL(string: URL_LOAD_DATA_DTAIL)
        guard let url = url else {
            return
        }
        
        let jobID = RequestJobDetail()
        jobID.jobID = jobDetailId
        
        let reqBody = RequestBody(module: Module.JobDetail.rawValue,
                                  target: Module.JobDetail.rawValue,
                                  data: jobID)
       
        
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
                        try JSONDecoder().decode(JobDetailModel.self, from: data)
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
    
}
