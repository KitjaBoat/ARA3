//
//  NewJobViewModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import Foundation

class NewJobViewModel {
//    let jobUrl = "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/2_NewJob/Data/Data/data.json"
        let jobUrl = "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/3_JobList/Data/Data/data.json"
    
    var jobList: [JobMedel]?
    
    func loadJob(completion:@escaping([JobDetail])->Void) {
        let url = URL(string: "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/13_RejectHistory/Data/JobRejectList/data.json")
        
        guard let url = url else {
            return
        }
        
        let reqBody:[String: Any] = ["module": "JobList",
                                     "target": "JobList",
                                     "token" : "zaPS4{N,n]X5timY#0A})P*oHIsk<Q4IC~Y(f)e,uY#igkP)?ZSP6<<FGGJ<V+/S"]
        
        
//        "zaPS4{N,n]X5timY#0A})P*oHIsk<Q4IC~Y(f)e,uY#igkP)?ZSP6<<FGGJ<V+/S"
        
        let jsonData = try? JSONSerialization.data(withJSONObject: reqBody)
        
//        let jsonEncoder = JSONEncoder()
//        let jsonData = try? jsonEncoder.encode(reqBody)
        var requst = URLRequest(url: url)
        requst.httpMethod = "POST"
        requst.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requst.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: requst) { data, response, error in
//            guard let data = data else {
//                return
//            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                print(data)
                if httpResponse.statusCode == 200 {
                    do {
                        let decode =
                        try JSONDecoder().decode(JobMedel.self, from: data!)
                        
                        completion(decode.entries)
                    } catch  {
                        print("error")
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


