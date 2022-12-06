//
//  RejectTableViewCell.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 2/12/2565 BE.
//

import UIKit

class RejectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleIcon: UIImageView!
    @IBOutlet weak var titleFirstLabel: UILabel!
    @IBOutlet weak var titleSecondLabel: UILabel!
    @IBOutlet weak var titleSecondIcon: UIImageView!
    @IBOutlet weak var subTitleFristLabel: UILabel!
    @IBOutlet weak var subTitleSecondLeftLabel: UILabel!
    @IBOutlet weak var subTitleSecondRightLabel: UILabel!
    @IBOutlet weak var subTitleThirdLeftLabel: UILabel!
    @IBOutlet weak var subTitleThirdRightLabel: UILabel!
    @IBOutlet weak var buttomFristLabel: UILabel!
    @IBOutlet weak var buttomSecondLabel: UILabel!
    @IBOutlet weak var subTitleFristIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
