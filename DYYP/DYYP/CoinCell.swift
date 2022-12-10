//
//  CoinCell.swift
//  DYPP
//
//  Created by Peyton Adkins on 11/11/22.
//

import UIKit

class CoinCell: UITableViewCell {
    var buying = true
    var reload = false
    
    @IBOutlet weak var coinLogoImage: UIImageView!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var ownedLabel: UILabel!
    @IBOutlet weak var purchaseStaticButton: UIButton!
    @IBOutlet weak var sellStaticButton: UIButton!
    @IBOutlet weak var sellButtonOutlet: UIButton!
    
    //sellButtonOutlet.isHidden = false
    
    @IBAction func purchaseButton(_ sender: Any) {
        buying = true
        dollarsign.isHidden = false
        confirmButtonOutlet.isHidden = false
        confirmButtonOutlet.isEnabled = true
        purchaseAmount.isEnabled = true
        purchaseAmount.isHidden = false
        purchaseAmount.becomeFirstResponder()
     
        self.purchaseStaticButton.backgroundColor = UIColor.lightGray
        self.sellStaticButton.backgroundColor = UIColor(named: "Toggle Colors")
    }
    
    @IBAction func sellButton(_ sender: Any) {
        buying = false
        dollarsign.isHidden = false
        confirmButtonOutlet.isHidden = false
        confirmButtonOutlet.isEnabled = true
        purchaseAmount.isEnabled = true
        purchaseAmount.isHidden = false
        purchaseAmount.becomeFirstResponder()
        
        self.sellStaticButton.backgroundColor = UIColor.lightGray
        self.purchaseStaticButton.backgroundColor = UIColor(named: "Toggle Colors")
    }
    
    
    //I'm sorry to anyone who tries to understand this button
    @IBAction func confirmButton(_ sender: Any) {
        confirmButtonOutlet.isHidden = true
        confirmButtonOutlet.isEnabled = false
        sellButtonOutlet.isHidden = false
        dollarsign.isHidden = true
        
        print((coinNameLabel.text ?? "dyypcoin") + " $" + (purchaseAmount.text ?? "0.00"))
        var owned = (settings.userData[settings.whiteRemover(string: coinNameLabel.text ?? "dyypcoin")] as? Double ?? 0.00)
        
        let price = apiCaller.cryptos[informationLabel.text!]!["price_usd"] as! Double
        var purchase = (Double(purchaseAmount.text!) ?? 0.00)
        
        purchase = purchase / price
        if buying == false { //selling
            if purchase >= owned{
                purchase = owned
                purchaseAmount.text = String(owned * price)
            }
            purchase = purchase * -1
        }
        var moneyEarned = (-1 * purchase * price) + (settings.userData["moneyEarned"] as! Double)
        settings.updateUserData(dataKey: "moneyEarned", dataValue: moneyEarned)
        var newTotal = purchase + owned
        if newTotal > 0 {
            var roundedTotal = Double(round(100000 * newTotal) / 100000)
//            ownedLabel.text = (String(roundedTotal) + " " + informationLabel.text!)
            ownedLabel.text = (String(roundedTotal))
            sellButtonOutlet.isEnabled = true
            sellButtonOutlet.isHidden = false
            settings.updateCoinsArray(coin: informationLabel.text!)
        } else {
            var currentCoins = (settings.userData["coinsOwned"] as! Array<String>)
            if let index = currentCoins.firstIndex(of: (informationLabel.text)!) {
                currentCoins.remove(at: index) // removed from coinsOwned
                print("removed")
                settings.userData["coinsOwned"] = currentCoins
                ownedLabel.text = "None!"
                sellButtonOutlet.isEnabled = false
                sellButtonOutlet.isHidden = true
            }
        }
        settings.updateUserData(dataKey: (settings.whiteRemover(string: coinNameLabel.text ?? "dyypcoin") ?? "dyypcoin"), dataValue: newTotal)
        purchaseAmount.text = ""
        purchaseAmount.isEnabled = false
        purchaseAmount.isHidden = true
        reload = true
        
        self.purchaseStaticButton.backgroundColor = UIColor(named: "Toggle Colors")
        self.sellStaticButton.backgroundColor = UIColor(named: "Toggle Colors")
    }
    
    @IBOutlet weak var purchaseAmount: UITextField!
    
    @IBOutlet weak var confirmButtonOutlet: UIButton!
    
    
    @IBOutlet weak var dollarsign: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
