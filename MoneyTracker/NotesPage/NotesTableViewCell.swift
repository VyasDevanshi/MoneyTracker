//
//  NotesTableViewCell.swift
//  MoneyTracker
//
//  Created by Mac on 18/12/1944 Saka.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var contentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
