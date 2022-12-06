//
//  AttachFileTableViewCell.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 6/12/2565 BE.
//

import UIKit

class AttachFileTableViewCell: UITableViewCell {
    @IBOutlet weak var labelLeft: UILabel!
    @IBOutlet weak var labelRight: UILabel!
    @IBOutlet weak var iconFirst: UIImageView!
    @IBOutlet weak var iconSecond: UIImageView!
    
    var attachFile:Attachment?

    override func awakeFromNib() {
        super.awakeFromNib()
        setActionOnIcon()
        setUpCell()
    }
    
    func setUpCell() {
        guard let attachFileList = attachFile else {
            return
        }

        labelLeft.text = attachFileList.title
        iconSecond.image = UIImage(named: "ic_transac_active")
        
    }
    
    func setActionOnIcon() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        iconSecond.isUserInteractionEnabled = true
        iconSecond.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        _ = tapGestureRecognizer.view as! UIImageView
        
        if let attachFileUrl = attachFile?.url {
            guard let url = URL(string: attachFileUrl.replacingOccurrences(of: " ", with: "%20")) else { return }
            UIApplication.shared.open(url)
        } 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
