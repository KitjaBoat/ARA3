//
//  SettingViewModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 1/12/2565 BE.
//

import Foundation

class SettingViewModel {
    let user = LoginResponse.current?.user
    
    func setupDataForTableView() -> [User?] {
        var containerUser = [User?]()
        containerUser.append(user)
        containerUser.append(nil)
        return containerUser
    }
}
