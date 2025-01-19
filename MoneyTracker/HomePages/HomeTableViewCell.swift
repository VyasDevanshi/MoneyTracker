//
//  HomeTableViewCell.swift
//  MoneyTracker
//
//  Created by Mac on 18/12/1944 Saka.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var lblAccount: UILabel!
    
    @IBOutlet weak var lblAmount: UILabel!
    
    @IBOutlet weak var lblNote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
