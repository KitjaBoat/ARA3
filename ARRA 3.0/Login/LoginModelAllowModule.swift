//
//  LoginModelAllowModule.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import Foundation

import Foundation

// MARK: - Welcome
struct LoginModelAllowModule: Codable {
    let status: Int
    let message: String
    let entries: Entries
}

// MARK: - Entries
class Entries: Codable {
    var user: User?
    var allowModule: [String]?
    var webService: [WebService]?
    var token: String?
    
//    init(user:User,allowModule:[String]) {
//        self.user = user
//        self.allowModule = allowModule
//    }
//    
    
}

// MARK: - User
struct User: Codable {
    let userID, name, role: String
    let config: Config
}

// MARK: - Config
struct Config: Codable {
    let repairImageLimit: Int
}

// MARK: - WebService
struct WebService: Codable {
    let key: String
    let url: String
}
