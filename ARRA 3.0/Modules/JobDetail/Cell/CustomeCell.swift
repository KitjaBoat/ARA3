//
//  MapTableViewCell.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import UIKit

class CustomeCell: UITableViewCell {
    
    @IBOutlet weak var headLabel: UILabel!

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var rightIconMain: UIImageView!
    @IBOutlet weak var rightHeadLabel: UILabel!
    @IBOutlet weak var rightmainLabel: UILabel!
    
    @IBOutlet weak var rightIcon: UIImageView!
    @IBOutlet weak var rightIconmainLabel: UILabel!
    
    
    @IBOutlet weak var click: UIButton!
    
    @IBOutlet weak var engButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func action(_ sender: Any) {
    }
    
    @IBAction func engAccept(_ sender: Any) {
    }
}
