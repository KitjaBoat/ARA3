//
//  Int.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 29/11/2565 BE.
//

import Foundation

import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

extension Int {

 var seconds: Int {
    return self
 }

 var minutes: Int {
    return self.seconds * 60
 }

 var hours: Int {
    return self.minutes * 60
 }

 var days: Int {
    return self.hours * 24
 }

 var weeks: Int {
    return self.days * 7
 }

 var months: Int {
    return self.weeks * 4
 }

 var years: Int {
    return self.months * 12
 }
}

enum HashError: Error {
    case DataError
}

extension String {
    func MD5() throws -> String {
        if let data: Data = self.data(using: .utf8) {
            var hashValueUInt8List: [UInt8] = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))

            _ = data.withUnsafeBytes({ (u8Prt: UnsafePointer<UInt8>) in
                CC_MD5(u8Prt, CC_LONG(data.count), &hashValueUInt8List)
            })

            let hashValue: String = hashValueUInt8List.map({ (num: UInt8) -> String in
                String(format: "%02hhx", num)
            }).joined()

            return hashValue
        }

        throw HashError.DataError
    }
}

