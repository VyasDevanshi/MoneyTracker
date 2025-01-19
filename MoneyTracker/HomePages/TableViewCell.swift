//
//  TableViewCell.swift
//  MoneyTracker
//
//  Created by TechExtensor PVT LTD on 07/04/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     
    
}
