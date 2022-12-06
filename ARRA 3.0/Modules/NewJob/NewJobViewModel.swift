//
//  NewJobViewModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import Foundation
import Alamofire

class NewJobViewModel {
//    let jobUrl = "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/2_NewJob/Data/Data/data.json"
        let jobUrl = "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/3_JobList/Data/Data/data.json"
    
    var jobList: [JobMedel]?
    
    func loadJob(completion:@escaping([JobDetail])->Void) {
        let url = URL(string: "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/2_NewJob/Data/Data/data.json")
        
        let rejectUrl = URL(string: "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/13_RejectHistory/Data/JobRejectList/data.json")
        
        guard let url = url else {
            return
        }
        
        let reqBody = RequestBody(module: "NewJob",
                                  target: "JobList",
                                  data: nil)
        
        let jsonData = try? JSONEncoder().encode(reqBody)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
               
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
    
    func postRequest() {
      let parameters: [String : Any] = [
        "module" : "NewJob",
        "target" : "JobList",
        "token" : "zaPS4{N,n]X5timY#0A})P*oHIsk<Q4IC~Y(f)e,uY#igkP)?ZSP6<<FGGJ<V+/S"
      ]
      
      let url = URL(string: "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/2_NewJob/Data/Data/data.json")!
      AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .validate()
        .responseJSON { response in
          switch response.result {
          case .success(let response):
            print(response)
          case .failure(let error):
            print(error.localizedDescription)
          }
      }
    }
    
    
    
}


