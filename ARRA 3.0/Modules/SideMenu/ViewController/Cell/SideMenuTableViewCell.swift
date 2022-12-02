//
//  SideMenuTableViewCell.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 30/11/2565 BE.
//

import UIKit



class SideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var home: UIButton!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func goToHome(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("goHome"), object: nil)
    }
    
}
