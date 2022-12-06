//
//  RejecHistoryViewModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 1/12/2565 BE.
//

import Foundation

class RejecHistoryViewModel {
    let URL_LOAD_DATA =  "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/13_RejectHistory/Data/JobRejectList/data.json"
    
    

    
    var jobList: [Job]?
//    var isFirst = true
    
    func loadJobData(compltion:@escaping([JobDetail]) -> Void) {
        let url = URL(string: URL_LOAD_DATA)
        guard let url = url else {
            return
        }
        
        let reqBody = RequestBody(module: Module.RejectHistrory.rawValue,
                                  target: "JobRejectList",
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
