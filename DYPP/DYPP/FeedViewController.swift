//
//  FeedViewController.swift
//  DYPP
//
//  Created by luciano scarpaci on 11/9/22.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //TABLEVIEW
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TABLEVIEW
        tableView.dataSource = self
        tableView.delegate = self
        
        //DARKMODE
        overrideUserInterfaceStyle = .dark
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedCell
        let btc = "BTC"
        let bch = "BCH"
        let eth = "ETH"
        let xrp = "XRP"
        let doge = "DOGE"
        let ltc = "LTC"
        
        let btcIMG = apiCaller.crypto_icons["BTC"]
        let bchIMG = apiCaller.crypto_icons["BCH"]
        let ethIMG = apiCaller.crypto_icons["ETH"]
        let xrpIMG = apiCaller.crypto_icons["XRP"]
        let dogeIMG = apiCaller.crypto_icons["DOGE"]
        let ltcIMG = apiCaller.crypto_icons["LTC"]
        
        
        
        if(apiCaller.cryptos.count > 0){
            if indexPath.row == 0 {
            cell.nameLabel?.text = apiCaller.cryptos[btc]!["name"] as! String
                cell.symbolLabel?.text = apiCaller.cryptos[btc]!["asset_id"] as! String
                cell.coinLabel.af.setImage(withURL: btcIMG!)
            
            if let showBTCPrice = apiCaller.cryptos[btc]!["price_usd"] as? Double {
                cell.price_usdLabel?.text = "USD $" + String(round(showBTCPrice * 100) / 100)
            }
        }
            if indexPath.row == 1 {
                cell.nameLabel?.text = apiCaller.cryptos[eth]!["name"]
                    as! String
                cell.symbolLabel?.text = apiCaller.cryptos[eth]!["asset_id"] as! String
                cell.coinLabel.af.setImage(withURL: ethIMG!)
                if let showETHPrice = apiCaller.cryptos[eth]!["price_usd"] as? Double {
                    cell.price_usdLabel?.text = "USD $" +
                        String(round(showETHPrice * 100) / 100)
                }
            }
            
            if indexPath.row == 2 {
                cell.nameLabel?.text = apiCaller.cryptos[bch]!["name"]
                as! String
                cell.symbolLabel?.text = apiCaller.cryptos[bch]!["asset_id"] as! String
                cell.coinLabel.af.setImage(withURL: bchIMG!)
                if let showBCHPrice = apiCaller.cryptos[bch]!["price_usd"]
                    as? Double {
                    cell.price_usdLabel?.text = "USD $" +
                        String(round(showBCHPrice * 100) / 100)
                }
            }
            
            if indexPath.row == 3 {
                cell.nameLabel?.text = apiCaller.cryptos[xrp]!["name"]
                as! String
                cell.symbolLabel?.text = apiCaller.cryptos[xrp]!["asset_id"] as! String
                cell.coinLabel.af.setImage(withURL: xrpIMG!)
                if let showBCHPrice = apiCaller.cryptos[xrp]!["price_usd"]
                    as? Double {
                    cell.price_usdLabel?.text = "USD $" +
                        String(round(showBCHPrice * 10000) / 10000)
                }
            }
            
            if indexPath.row == 4 {
                cell.nameLabel?.text = apiCaller.cryptos[doge]!["name"]
                as! String
                cell.symbolLabel?.text = apiCaller.cryptos[doge]!["asset_id"] as! String
                cell.coinLabel.af.setImage(withURL: dogeIMG!)
                if let showDOGEPrice = apiCaller.cryptos[doge]!["price_usd"]
                    as? Double {
                    cell.price_usdLabel?.text = "USD $" +
                        String(round(showDOGEPrice * 10000) / 10000)
                }
            }
            
            if indexPath.row == 5 {
                cell.nameLabel?.text = apiCaller.cryptos[ltc]!["name"]
                as! String
                cell.symbolLabel?.text = apiCaller.cryptos[ltc]!["asset_id"] as! String
                cell.coinLabel.af.setImage(withURL: ltcIMG!)
                if let showLTCPrice = apiCaller.cryptos[ltc]!["price_usd"]
                    as? Double {
                    cell.price_usdLabel?.text = "USD $" +
                        String(round(showLTCPrice * 1000) / 1000)
                }
            }
        }
        
        
        return cell
    }

}



