//
//  AlertManager.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 29/11/2565 BE.
//

import Foundation
import UIKit

class AlertManager {
    
    static func alertLogin(messae:String?, self:UIViewController) {
        let alert = UIAlertController(title: "", message: messae ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
