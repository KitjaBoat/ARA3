//
//  ModuleCellCollectionViewCell.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import UIKit

class ModuleCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    var titleLabel:String?
    var model:WidGetList?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func setupCell() {
        guard let model = model else {
            return
        }
        title.text = model.title
        iconImage.image = model.icon
    }
}

struct WidGetList {
    var title:String
    var icon:UIImage
    var notification:Int?
    
    init(title:String, icon:UIImage){
        self.title = title
        self.icon = icon
    }
}
