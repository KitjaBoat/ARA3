//
//  LoginViewModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import Foundation

class LoginViewModel {
    var loginURL = "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/1_Authentication/AServiceLogin/login.json"
    
//    func normalLogin(completionHanler:@escaping(LoginResponse) -> Void) {
//        let url = URL(string: loginURL)
//        var urlRequest = URLRequest(url: url!)
//        let requestLogin = RequestLogin(username: "AAAAA", password: "BBBBBB")
//
//
//        let body = ["module" : "Authentication",
//                    "traget" : "Login",
//                    "data" : ["username": "user1",
//                              "password": "e10adc3949ba59abbe56e057f20f883e",
//                              "deviceInfo": [
//                                "deviceName": "iPhone 11 Pro Max",
//                                "os": "iOS",
//                                "osVersion": "13.3",
//                                "macAddress": "EF79184D-F7A4-4265-A556-E9B0588066E3"]
//                             ]
//        ] as [String : Any]
//
//
//
//
//
//        urlRequest.httpMethod = "Post"
//        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//
//
//        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//
//            if data != nil {
//                do {
//                    let decode = try JSONDecoder().decode(LoginResponse.self, from: data!)
//                    completionHanler(decode)
//                }catch {
//                    print("error")
//                }
//            }
//        }
//        task.resume()
//    }
    
    func apiPost(username:String,password:String, completion:@escaping(LoginModelAllowModule)->Void){
        let url = URL(string: loginURL)
        
        guard let url = url else {
            return
        }
        
        let uploadData:Dictionary<String, Any> =
        [
            "module": "Authentication",
            "target": "Login",
            "data":
                ["username": "\(username)",
                 "password": "\(password)"],
            "deviceInfo": [
                "deviceName": "iPhone 11 Pro Max",
                "os": "iOS",
                "osVersion": "13.3",
                "macAddress": "EF79184D-F7A4-4265-A556-E9B0588066E3"]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: uploadData, options: [])
        var requst = URLRequest(url: url)
        requst.httpMethod = "POST"
        requst.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requst.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: requst) { data, response, error in
            guard let data = data else {
                return
            }
            do { let decode =
                try JSONDecoder().decode(LoginModelAllowModule.self, from: data)
                
                Modules.shared.allow = decode.entries.allowModule
                completion(decode)
            } catch  {
                print("error")
            }

    }
        task.resume()
    
}
}
