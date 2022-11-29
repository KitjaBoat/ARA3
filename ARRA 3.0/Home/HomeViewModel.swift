//
//  HomeViewModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import Foundation

class HomeViewModel {
    let urlData =  "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/NewASale/12_Home/NotificationCount/data.json"
    let urlJobData =  "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/2_NewJob/Data/Data/data.json"
    
    func loadJobData(compltion:@escaping([JobDetail]) -> Void) {
        let url = URL(string: urlJobData)
        
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
