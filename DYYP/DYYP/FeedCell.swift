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
    
    @IBAction func purchaseButton(_ sender: Any) {
        dollarsign.isHidden = false
        confirmButtonOutlet.isHidden = false
        confirmButtonOutlet.isEnabled = true
        purchaseAmount.isEnabled = true
        purchaseAmount.isHidden = false
        purchaseAmount.becomeFirstResponder()
    }
    @IBAction func confirmButton(_ sender: Any) {
        confirmButtonOutlet.isHidden = true
        confirmButtonOutlet.isEnabled = false
        dollarsign.isHidden = true

        print((nameLabel.text ?? "dyypcoin") + " $" + (purchaseAmount.text ?? "0.00"))
        var owned = (settings.userData[nameLabel.text ?? "dyypcoin"] as? Double ?? 0.00)
        
        var purchase = (Double(purchaseAmount.text!) ?? 0.00)
        
        purchase = purchase + owned
        settings.updateUserData(dataKey: (settings.whiteRemover(string: nameLabel.text ?? "dyypcoin") ?? "dyypcoin"), dataValue: purchase)
        purchaseAmount.text = ""
        purchaseAmount.isEnabled = false
        purchaseAmount.isHidden = true
        
    }
    
    @IBOutlet weak var confirmButtonOutlet: UIButton!
    @IBOutlet weak var dollarsign: UILabel!
    
    @IBOutlet weak var purchaseAmount: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
