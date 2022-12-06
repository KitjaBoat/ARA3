//
//  ManageEngineerTableViewCell.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 6/12/2565 BE.
//

import UIKit

class ManageEngineerTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var switchEnable: UISwitch!
    
    var engineer:Engineer?
    var hiddenSwitch: Bool?
    var enableSwitch: Bool?
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
        labelTitle.text = engineer?.name
        labelTitle.textColor = .black
        switchEnable.isHidden = hiddenSwitch ?? false
        
        if enableSwitch == false {
            switchEnable.isEnabled = false
        }else {
            switchEnable.isEnabled = true
        }
        
    }
    
}
