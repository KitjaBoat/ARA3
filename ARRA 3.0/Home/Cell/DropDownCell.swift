//
//  DropDownCell.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 29/11/2565 BE.
//

import UIKit
import DropDown

class CustomDropDownCell:DropDownCell {
    
    @IBOutlet var iconImage:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImage.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
