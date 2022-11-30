//
//  PopoverTableViewCell.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 30/11/2565 BE.
//

import UIKit

class PopoverTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
