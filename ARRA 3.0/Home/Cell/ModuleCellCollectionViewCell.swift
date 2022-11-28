//
//  ModuleCellCollectionViewCell.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import UIKit

class ModuleCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    
    var titleLabel:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title.text = titleLabel
    }

}
