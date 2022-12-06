//
//  CoinCell.swift
//  DYPP
//
//  Created by Peyton Adkins on 11/11/22.
//

import UIKit

class CoinCell: UITableViewCell {
    var buying = true
    
    @IBOutlet weak var coinLogoImage: UIImageView!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var ownedLabel: UILabel!
    @IBOutlet weak var purchaseStaticButton: UIButton!
    @IBOutlet weak var sellStaticButton: UIButton!
    @IBOutlet weak var sellButtonOutlet: UIButton!
    
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
    
    @IBAction func confirmButton(_ sender: Any) {
        confirmButtonOutlet.isHidden = true
        confirmButtonOutlet.isEnabled = false
        dollarsign.isHidden = true

        print((coinNameLabel.text ?? "dyypcoin") + " $" + (purchaseAmount.text ?? "0.00"))
        var owned = (settings.userData[settings.whiteRemover(string: coinNameLabel.text ?? "dyypcoin")] as? Double ?? 0.00)
        
        let ownedLabelText = ownedLabel.text ?? "0.00"
        let price = apiCaller.cryptos[informationLabel.text!]!["price_usd"] as! Double
        var purchase = (Double(purchaseAmount.text!) ?? 0.00)
        if buying == false { //selling
            if purchase >= owned{
                purchase = owned
                purchaseAmount.text = String(owned)
            }
            purchase = purchase * -1
        }
        purchase = purchase + owned
        print("purchase = " + String(purchase))
        if purchase > 0 {
            settings.updateCoinsArray(coin: informationLabel.text!)
        } else {
            print("purchase = 0")
            print("info is " + informationLabel.text!)
            var currentCoins = (settings.userData["coinsOwned"] as! Array<String>)
            if let index = currentCoins.firstIndex(of: (informationLabel.text)!) {
                currentCoins.remove(at: index) // removed from coinsOwned
                print("removed")
                settings.userData["coinsOwned"] = currentCoins
                informationLabel.text = "You no longer own this coin!"
                sellButtonOutlet.isEnabled = false
                sellButtonOutlet.isHidden = true
            }
        }
        settings.updateUserData(dataKey: (settings.whiteRemover(string: coinNameLabel.text ?? "dyypcoin") ?? "dyypcoin"), dataValue: purchase)
        purchaseAmount.text = ""
        purchaseAmount.isEnabled = false
        purchaseAmount.isHidden = true
        ownedLabel.text = String(purchase / price)
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
