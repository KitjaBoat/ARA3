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
    
    func loadJobData(module:String ,compltion:@escaping([JobDetail]) -> Void) {
        print("Thsi is module \(module)")
        var urlString:String?
        
        if module == Module.Newjob.rawValue {
            urlString = newJobUrl
        }
        else if module == Module.Joblist.rawValue {
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
}
