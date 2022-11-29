//
//  KeychainManager.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 29/11/2565 BE.
//

import Foundation
import Security

public enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

public class KeychainManager {
    
    public static func save(
        username: String,
        password: Data
    ) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: username,
            kSecValueData as String: password
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            let error = KeychainError.unhandledError(status: status)
            
            if status == errSecDuplicateItem {
                do {
                    try update(
                        username: username,
                        password: password
                    )
                } catch {
                    throw error
                }
            }
            
            throw error
        }
    }
    
    public static func get(
        username: String
    ) throws -> (String, String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: username,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else {
            throw KeychainError.noPassword
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }
        
        guard let existingItem = item as? [String : Any],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8),
            let account = existingItem[kSecAttrAccount as String] as? String
        else {
            throw KeychainError.unexpectedPasswordData
        }
        
        return (account, password)
    }
    
    private static func update(
        username: String,
        password: Data
    ) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: username
        ]
        
        let updateFields = [
            kSecValueData: password
        ] as CFDictionary
        
        let status = SecItemUpdate(query as CFDictionary, updateFields)
        
        guard status == errSecSuccess else {
            let error = KeychainError.unhandledError(status: status)
            throw error
        }
    }
    
    public static func delete(
        username: String
    ) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: username
        ]
        
        let status = SecItemDelete( query as CFDictionary )
        
        guard status == errSecSuccess else {
            let error = KeychainError.unhandledError(status: status)
            throw error
        }
    }
    
}
