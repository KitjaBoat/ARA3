//
//  CacheManager.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 29/11/2565 BE.
//

import Foundation
import UIKit


class CacheManager {
//    static let sharedInstance = CacheManager()
//
//    private init() { }
    
    static func save(loginResponse :LoginResponse) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(loginResponse)
            UserDefaults.standard.set(data, forKey: "LOGIN_CACHE")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    static func get(key:String) -> LoginResponse? {
        var loginResponse:LoginResponse?
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode(LoginResponse.self, from: data)
                loginResponse = decodeData
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return loginResponse
    }
    
    static func delete(key:String){
        UserDefaults.standard.removeObject(forKey: key)
    }
}
