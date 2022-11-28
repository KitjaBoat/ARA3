////
////  LoginModel.swift
////  ARRA 3.0
////
////  Created by ARSOFT on 25/11/2565 BE.
////
//
//import Foundation
//
//class LoginResponse:Codable {
//    
//        let status: Int
//        let message: String
//        let entries: Entries
//    }
//
//    // MARK: - Entries
//    struct Entries: Codable {
//        let user: User
//        let allowModule: [String]
//        let webService: [WebService]
//        let token: String
//    }
//
//    // MARK: - User
//    struct User: Codable {
//        let uniqueID: Int
//        let name, role: String
//        let businessUnit: [BusinessUnit]
//        let autoApproval: Bool
//    }
//
//    // MARK: - BusinessUnit
//    struct BusinessUnit: Codable {
//        let uniqueID: Int
//        let name: String
//        let roleID: Int
//        let role: String
//        let isEnablePipelineOpportunity: Bool
//    }
//
//    // MARK: - WebService
//    struct WebService: Codable {
//        let key: String
//        let url: String
//    }
//
