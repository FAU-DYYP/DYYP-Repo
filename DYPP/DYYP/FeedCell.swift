//
//  FeedCell.swift
//  DYPP
//
//  Created by luciano scarpaci on 11/18/22.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var symbolLabel: UILabel!
    
    
    @IBOutlet weak var price_usdLabel: UILabel!
    
    @IBOutlet weak var coinLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
