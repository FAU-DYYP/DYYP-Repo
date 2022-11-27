//
//  CoinCell.swift
//  DYPP
//
//  Created by Peyton Adkins on 11/11/22.
//

import UIKit

class CoinCell: UITableViewCell {

    @IBOutlet weak var coinLogoImage: UIImageView!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var ownedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
