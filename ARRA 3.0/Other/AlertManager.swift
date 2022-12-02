//
//  AlertManager.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 29/11/2565 BE.
//

import Foundation
import UIKit

protocol AlertMangerDelegate {
    func logout()
}

class AlertManager {
    var delegate:AlertMangerDelegate?
    
    static func alertLogin(messae:String?, self:UIViewController) {
        let alert = UIAlertController(title: "", message: messae ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertLogout(view:UIViewController){
        let alert = UIAlertController(title: "", message: "คุณต้องการออกจาระบบ", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: {_ in
            view.dismiss(animated: true, completion: nil)
            self.delegate?.logout()
            
        }))
        view.present(alert, animated: true, completion: nil)
        
    }
}
