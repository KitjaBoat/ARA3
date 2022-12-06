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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchToggle(_ sender: Any) {
        if switchEnable.isOn {
            icon.image = UIImage(named: "ic_eng_accept")
        }else if !switchEnable.isOn {
            icon.image = UIImage(named: "ic_eng_noaccept")
        }
    }
    
    func checkLead(){
        if engineer?.isLead != nil {
            switchEnable.isHidden = true
        }
    }
    
    func checkAccepted(){
        if engineer?.accepted == true {
            switchEnable.isOn = true
            icon.image = UIImage(named: "ic_eng_accept")
        }else if engineer?.accepted == false {
            switchEnable.isOn = false
            icon.image = UIImage(named: "ic_eng_noaccept")
        }
    }
    
    
    
    func setupCell() {
        labelTitle.text = engineer?.name
        labelTitle.textColor = .black
//        switchEnable.isHidden = hiddenSwitch ?? false
//        icon.image = UIImage(named: "ic_eng_noaccept")
        
        if enableSwitch == false {
            switchEnable.isEnabled = false
            icon.image = UIImage(named: "ic_eng_noaccept")
        }else if enableSwitch == true {
            switchEnable.isEnabled = true
            icon.image = UIImage(named: "ic_eng_accept")
        }
        
       
        
    }
    
}
