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
        confirmButtonOutlet.isEnabled = true
        confirmButtonOutlet.isHidden = false
        purchaseAmount.isEnabled = true
        purchaseAmount.isHidden = false
        purchaseAmount.becomeFirstResponder()
    }
    @IBAction func confirmButton(_ sender: Any) {
        

        print((nameLabel.text ?? "dyypcoin") + " $" + (purchaseAmount.text ?? "0.00"))
        var owned = (settings.userData[nameLabel.text ?? "dyypcoin"] as? Double ?? 0.00)
        print("feed owned from userdata " + String(owned))
        
        var purchase = (Double(purchaseAmount.text!) ?? 0.00)
        print("feed purchase from field " + String(purchase))
        let price = apiCaller.cryptos[symbolLabel.text!]!["price_usd"] as! Double
        print("feed price " + String(price))
        purchase = purchase / price
        print("feed purchase/price " + String(purchase))
        let newTotal = purchase + owned
        print("feed purchase+owned " + String(newTotal))
        if newTotal > 0 && owned == 0.00 {
            settings.updateCoinsArray(coin: symbolLabel.text!)
        }
        settings.updateUserData(dataKey: (settings.whiteRemover(string: nameLabel.text ?? "dyypcoin") ?? "dyypcoin"), dataValue: newTotal)
        purchaseAmount.text = ""
        purchaseAmount.isEnabled = false
        purchaseAmount.isHidden = true
        
        dollarsign.isHidden = true
        confirmButtonOutlet.isHidden = true
        confirmButtonOutlet.isEnabled = false
        
        var moneyEarned = (-1 * purchase * price) + (settings.userData["moneyEarned"] as! Double)
        settings.updateUserData(dataKey: "moneyEarned", dataValue: moneyEarned)
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
