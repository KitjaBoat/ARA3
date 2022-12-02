//
//  SettingTableViewCell.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 1/12/2565 BE.
//

import UIKit

class SettingCell: UITableViewCell {
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var footer: UILabel!
    
    var user:User?
   

    override func awakeFromNib() {
        super.awakeFromNib()
        header.textColor = UIColor(rgb: 0x1F35C7)
        
    }
    
    func setup() {
        if user?.name == nil {
            header.text = "About"
            content.text = "Version 3.0 Bata "
            footer.text = "Powered By ARSoft"
            footer.isHidden = false
        }else {
            header.text = "Account Info"
            content.text = user?.name
            footer.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
