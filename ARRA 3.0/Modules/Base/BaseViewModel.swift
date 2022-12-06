//
//  BaseViewModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 6/12/2565 BE.
//

import Foundation

class BaseViewModel {
    let URL_LOAD_DATA_DTAIL =  "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/3_JobList/Data/JobDetail/data.json"
    
    func loadJobDetailData(jobDetailId:Int,compltion:@escaping(JobDetail) -> Void) {
        let url = URL(string: URL_LOAD_DATA_DTAIL)
        guard let url = url else {
            return
        }
        
        let jobID = RequestJobDetail()
        jobID.jobID = jobDetailId
        
        let reqBody = RequestBody(module: "JobList",
                                  target: Module.JobDetail.rawValue,
                                  data: jobID)
        
//        let rawBody:[String: Any] = ["module": "JobList",
//                                     "target": "JobDetail",
//                                     "token": "zaPS4{N,n]X5timY#0A})P*oHIsk<Q4IC~Y(f)e,uY#igkP)?ZSP6<<FGGJ<V+/S",
//                                     "data":[
//                                        "jobID": "1"
//                                        ]
//        ]
        
//        let rawJsonData = try?  JSONSerialization.data(withJSONObject: rawBody, options: .prettyPrinted)
       
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(reqBody)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
//        request.httpBody = rawJsonData
        
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
