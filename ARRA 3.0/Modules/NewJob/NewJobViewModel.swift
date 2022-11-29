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
        let url = URL(string: jobUrl)
        
        guard let url = url else {
            return
        }
        
        let uploadData:Dictionary<String, Any> =
        [
            "module": "NewJob",
            "target": "JobList",
            "token": "zaPS4{N,n]X5timY#0A})P*oHIsk<Q4IC~Y(f)e,uY#igkP)?ZSP6<<FGGJ<V+/S"
          
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: uploadData, options: [])
        var requst = URLRequest(url: url)
        requst.httpMethod = "POST"
        requst.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requst.httpBody = jsonData
        
        
        
        let task = URLSession.shared.dataTask(with: requst) { data, response, error in
//            guard let data = data else {
//                return
//            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("error \(httpResponse.statusCode)")
            }
            
            do { let decode =
                try JSONDecoder().decode(JobMedel.self, from: data!)

                completion(decode.entries)
            } catch  {
                print("error")
            }

    }
        task.resume()
    
}
}


