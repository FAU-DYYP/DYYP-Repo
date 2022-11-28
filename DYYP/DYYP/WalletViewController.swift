//
//  WalletViewController.swift
//  DYPP
//
//  Created by luciano scarpaci on 11/9/22.
//

import UIKit
import Parse
import AlamofireImage

class WalletViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.reloadData()
        
        apiCaller.loadCryptoData()
        apiCaller.loadCryptoIcons()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 115
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 //TEMPORARY
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell") as! CoinCell
        let btc = "BTC"
        let bch = "BCH"
        let eth = "ETH"
        let xrp = "XRP"
        let doge = "DOGE"
        let ltc = "LTC"
        let xmr = "XMR"
        let dot = "DOT"
        let xlm = "XLM"
        let etc = "ETC"
        
        let btcIMG = apiCaller.crypto_icons["BTC"]
        let bchIMG = apiCaller.crypto_icons["BCH"]
        let ethIMG = apiCaller.crypto_icons["ETH"]
        let xrpIMG = apiCaller.crypto_icons["XRP"]
        let dogeIMG = apiCaller.crypto_icons["DOGE"]
        let ltcIMG = apiCaller.crypto_icons["LTC"]
        let xmrIMG = apiCaller.crypto_icons["XMR"]
        let dotIMG = apiCaller.crypto_icons["DOT"]
        let xlmIMG = apiCaller.crypto_icons["XLM"]
        let etcIMG = apiCaller.crypto_icons["ETC"]
        
        
        //tables load before data finishes loading
        if(apiCaller.cryptos.count > 0){
            if indexPath.row == 0 {
            //dictionary of dictionaries
            cell.coinNameLabel?.text = apiCaller.cryptos[doge]!["name"] as! String
                cell.coinLogoImage.af.setImage(withURL: dogeIMG!)
                cell.informationLabel?.text = apiCaller.cryptos[doge]!["data_start"] as! String
                if let ownedDoge = apiCaller.cryptos[doge]!["asset_id"] as?
                    String {
                    cell.ownedLabel?.text = "42.344 " + String(ownedDoge)
                }
            }
            if indexPath.row == 1 {
            //dictionary of dictionaries
            cell.coinNameLabel?.text = apiCaller.cryptos[xrp]!["name"] as! String
                cell.coinLogoImage.af.setImage(withURL: xrpIMG!)
                cell.informationLabel?.text = apiCaller.cryptos[xrp]!["data_start"] as! String
                if let ownedRipple = apiCaller.cryptos[xrp]!["asset_id"] as?
                    String {
                    cell.ownedLabel?.text = "789.22 " + String(ownedRipple)
                }
            }
            if indexPath.row == 2 {
            //dictionary of dictionaries
            cell.coinNameLabel?.text = apiCaller.cryptos[eth]!["name"] as! String
                cell.coinLogoImage.af.setImage(withURL: ethIMG!)
                cell.informationLabel?.text = apiCaller.cryptos[eth]!["data_start"] as! String
                if let ownedEther = apiCaller.cryptos[eth]!["asset_id"] as?
                    String {
                    cell.ownedLabel?.text = "0.0257 " + String(ownedEther)
                }
            }
            if indexPath.row == 3 {
            //dictionary of dictionaries
            cell.coinNameLabel?.text = apiCaller.cryptos[xmr]!["name"] as! String
                cell.coinLogoImage.af.setImage(withURL: xmrIMG!)
                cell.informationLabel?.text = apiCaller.cryptos[xmr]!["data_start"] as! String
                if let ownedMonero = apiCaller.cryptos[xmr]!["asset_id"] as?
                    String {
                    cell.ownedLabel?.text = "7.200 " + String(ownedMonero)
                }
            }
            if indexPath.row == 4 {
            //dictionary of dictionaries
            cell.coinNameLabel?.text = apiCaller.cryptos[etc]!["name"] as! String
                cell.coinLogoImage.af.setImage(withURL: etcIMG!)
                cell.informationLabel?.text = apiCaller.cryptos[etc]!["data_start"] as! String
                if let ownedEclassic = apiCaller.cryptos[etc]!["asset_id"] as? String {
                    cell.ownedLabel?.text = "26.12 " + String(ownedEclassic)
                }
            }
            if indexPath.row == 5 {
            //dictionary of dictionaries
            cell.coinNameLabel?.text = apiCaller.cryptos[ltc]!["name"] as! String
                cell.coinLogoImage.af.setImage(withURL: ltcIMG!)
                cell.informationLabel?.text = apiCaller.cryptos[ltc]!["data_start"] as! String
                if let ownedLitecoin = apiCaller.cryptos[ltc]!["asset_id"]
                    as? String {
                    cell.ownedLabel?.text = "1.11 " + String(ownedLitecoin)
                }
            }
            if indexPath.row == 6 {
            //dictionary of dictionaries
            cell.coinNameLabel?.text = apiCaller.cryptos[bch]!["name"] as! String
                cell.coinLogoImage.af.setImage(withURL: bchIMG!)
                cell.informationLabel?.text = apiCaller.cryptos[bch]!["data_start"] as! String
                if let ownedBitcoinCash = apiCaller.cryptos[bch]!["asset_id"] as? String {
                    cell.ownedLabel?.text = "20.000 " + String(ownedBitcoinCash)
                }
            }
            if indexPath.row == 7 {
            //dictionary of dictionaries
            cell.coinNameLabel?.text = apiCaller.cryptos[dot]!["name"] as! String
                cell.coinLogoImage.af.setImage(withURL: dotIMG!)
                cell.informationLabel?.text = apiCaller.cryptos[dot]!["data_start"] as! String
                if let ownedPolkadot = apiCaller.cryptos[dot]!["asset_id"] as? String {
                    cell.ownedLabel?.text = "3.23 " + String(ownedPolkadot)
                }
            }
            if indexPath.row == 8 {
            //dictionary of dictionaries
            cell.coinNameLabel?.text = apiCaller.cryptos[xlm]!["name"] as! String
                cell.coinLogoImage.af.setImage(withURL: xlmIMG!)
                cell.informationLabel?.text = apiCaller.cryptos[xlm]!["data_start"] as! String
                if let ownedStellar = apiCaller.cryptos[xlm]!["asset_id"] as? String {
                    cell.ownedLabel?.text = "173 " + String(ownedStellar)
                }
            }
            if indexPath.row == 9 {
            //dictionary of dictionaries
            cell.coinNameLabel?.text = apiCaller.cryptos[btc]!["name"] as! String
                cell.coinLogoImage.af.setImage(withURL: btcIMG!)
                cell.informationLabel?.text = apiCaller.cryptos[btc]!["data_start"] as! String
                if let ownedBitcoin = apiCaller.cryptos[btc]!["asset_id"] as? String {
                    cell.ownedLabel?.text = "0.254203 " + String(ownedBitcoin)
                }
            }
            
            
            

        }
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
