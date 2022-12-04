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
        if buying == false{
            purchaseAmount.text = "-" + purchaseAmount.text!
        }
        print((coinNameLabel.text ?? "coin") + (purchaseAmount.text ?? "0.00"))
        purchaseAmount.text = ""
        purchaseAmount.isEnabled = false
        purchaseAmount.isHidden = true
        
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
