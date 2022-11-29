//
//  JobDetailModel.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import Foundation
import UIKit

struct JobToSetupTableView {
    let title:String
    let icon:UIImage?
//    let handler: (() -> Void)
}

struct Section {
    let title:String
    let value:[JobToSetupTableView]
    
}
