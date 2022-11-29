//
//  LoginViewModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import Foundation
import UIKit


protocol ClearTextField{
    func clertext()
}

class LoginViewModel {
    var loginURL = "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/1_Authentication/AServiceLogin/login.json"
    var password:String?
    var reqLogin:RequestLogin?
    var switcherIsOn:Bool?
    var delegate:ClearTextField?
    var respone:LoginResponse?
    
    func loginChecker(userName:String? , password:String?) -> (Bool, String?) {
        guard let username = userName else {
            return (false, "กรุณากรอกชื่อผู้ใช้งาน")
        }
        if !(username.count >= 5) {
            return (false, "ชื่อผู้ใช้งานไม่ถูกต้อง")
        }
        
        guard let password = password else {
            return (false, "กรุณากรอกรหัสผ่าน")
        }
        if !(password.count >= 5) {
            return (false, "รหัสผ่านไม่ถูกต้อง")
        }
        else {
            self.password = password
            reqLogin = RequestLogin(username: username,
                                    password: try? password.MD5()
            )
        }
        return (true, nil)
    }
    
    func startLogin( completionHandler: @escaping (Bool, String?) -> Void ) {
        let url = URL(string: loginURL)
        
        guard let url = url else {
            return
        }
        
        let reqBody = RequestBody(module: "Authentication",
                                  target: "Login",
                                  data: reqLogin)
        
        print(reqBody.data.password)

        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(reqBody)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            guard let data = data else {
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    do {
                        let decode =
                        try JSONDecoder().decode(Welcome.self, from: data)
                        self.respone = decode.entries
                        
                        LoginResponse.current = decode.entries
                        self.loginCompletionHandler()
                        completionHandler(true, nil)
                        
                    } catch  {
                        print("errorDecode")
                    }
                }
                else {
                    print("errorStatusCode \(httpResponse.statusCode)")
                    completionHandler(false, "\(httpResponse.statusCode)")
                    //message
                    //status 2 =
                }
            }
        }
        task.resume()
    }
    
    func loginCompletionHandler() {
        guard let switcherIsOn = switcherIsOn else {
            return
        }
        
        if switcherIsOn{
            guard let username = reqLogin?.username else {
                return
            }
            
            guard let password = self.password?.data(using: .utf8)  else {
                return
            }
            try? KeychainManager.save(
                        username: username,
                        password: password
            )
            
            let preferences = UserDefaults.standard
            preferences.set(username, forKey: "KEY_USERNAME")
            
            //save login cache
            if let loginRes = LoginResponse.current{
                CacheManager.save(loginResponse: loginRes)
            }
            
        }else{
            guard let username = reqLogin?.username else {
                return
            }
            try? KeychainManager.delete(username: username)
            
            let preferences = UserDefaults.standard
            preferences.removeObject(forKey: "KEY_USERNAME")
            delegate?.clertext()
        }
    }
    
    func setupApplication() {
        
       
    }
}




