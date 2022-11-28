//
//  HomeModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import Foundation

class HomeModel{
    var allowModule:[Entries]
    
    init(allowModule:[Entries]) {
        self.allowModule = allowModule
    }
    
    func getAllowModule() -> [String]? {
        let module = Entries()
        let allowModeul = module.allowModule
        return allowModeul
    }
}
