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
    
    let feedRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TABLEVIEW
        tableView.dataSource = self
        tableView.delegate = self
        
        //DARKMODE
        //overrideUserInterfaceStyle = .light
        
        loadPrices()
        
        feedRefreshControl.addTarget(self, action: #selector(loadPrices), for: .valueChanged)
        tableView.refreshControl = feedRefreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadPrices()
    }

    
    @objc func loadPrices() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView.reloadData()
            self.feedRefreshControl.endRefreshing()
            //settings.getUserData()
            //print(settings.userData["username"] ?? "data not there yet")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedCell
        
        let coinArray = ["BTC", "BTC", "BCH", "ETH", "XRP", "DOGE", "LTC", "XMR", "DOT", "XLM", "ETC"]
        let imageArray = [
            apiCaller.crypto_icons["BTC"], //dummy
            apiCaller.crypto_icons["BTC"],
            apiCaller.crypto_icons["BCH"],
            apiCaller.crypto_icons["ETH"],
            apiCaller.crypto_icons["XRP"],
            apiCaller.crypto_icons["DOGE"],
            apiCaller.crypto_icons["LTC"],
            apiCaller.crypto_icons["XMR"],
            apiCaller.crypto_icons["DOT"],
            apiCaller.crypto_icons["XLM"],
            apiCaller.crypto_icons["ETC"]
        ]
        
        
        var preferredCoin = settings.userData["preferredCoin"] as! String
        if preferredCoin == "None Selected" {
            preferredCoin = "BTC"
        }
        let preferredImage = apiCaller.crypto_icons[preferredCoin]
        
        
        if(apiCaller.cryptos.count > 0){
            if indexPath.row == 0 {
            cell.nameLabel?.text = apiCaller.cryptos[preferredCoin]!["name"] as! String
                cell.symbolLabel?.text = apiCaller.cryptos[preferredCoin]!["asset_id"] as! String
                cell.coinLabel.af.setImage(withURL: preferredImage!)
            
            if let showPreferredPrice = apiCaller.cryptos[preferredCoin]!["price_usd"] as? Double {
                cell.price_usdLabel?.text = "USD $" + String(round(showPreferredPrice * 100) / 100)
            }
        }
            if indexPath.row == 1 {
                if preferredCoin != coinArray[indexPath.row] {
                    print("hello")
                    cell.nameLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["name"]
                        as! String
                    cell.symbolLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["asset_id"] as! String
                    cell.coinLabel.af.setImage(withURL: imageArray[indexPath.row]!)
                    if let price = apiCaller.cryptos[coinArray[indexPath.row]]!["price_usd"] as? Double {
                        cell.price_usdLabel?.text = "USD $" +
                            String(round(price * 100) / 100)
                }
                }
            }
            
            if indexPath.row == 2 {
                if preferredCoin != coinArray[indexPath.row] {
                    cell.nameLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["name"]
                        as! String
                    cell.symbolLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["asset_id"] as! String
                    cell.coinLabel.af.setImage(withURL: imageArray[indexPath.row]!)
                    if let price = apiCaller.cryptos[coinArray[indexPath.row]]!["price_usd"] as? Double {
                        cell.price_usdLabel?.text = "USD $" +
                            String(round(price * 100) / 100)
                }
                }
            }
            
            if indexPath.row == 3 {
                if preferredCoin != coinArray[indexPath.row] {
                    cell.nameLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["name"]
                        as! String
                    cell.symbolLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["asset_id"] as! String
                    cell.coinLabel.af.setImage(withURL: imageArray[indexPath.row]!)
                    if let price = apiCaller.cryptos[coinArray[indexPath.row]]!["price_usd"] as? Double {
                        cell.price_usdLabel?.text = "USD $" +
                            String(round(price * 100) / 100)
                }
                }
            }
            
            if indexPath.row == 4 {
                if preferredCoin != coinArray[indexPath.row] {
                    cell.nameLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["name"]
                        as! String
                    cell.symbolLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["asset_id"] as! String
                    cell.coinLabel.af.setImage(withURL: imageArray[indexPath.row]!)
                    if let price = apiCaller.cryptos[coinArray[indexPath.row]]!["price_usd"] as? Double {
                        cell.price_usdLabel?.text = "USD $" +
                            String(round(price * 100) / 100)
                }
                }
            }
            
            if indexPath.row == 5 {
                if preferredCoin != coinArray[indexPath.row] {
                    cell.nameLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["name"]
                        as! String
                    cell.symbolLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["asset_id"] as! String
                    cell.coinLabel.af.setImage(withURL: imageArray[indexPath.row]!)
                    if let price = apiCaller.cryptos[coinArray[indexPath.row]]!["price_usd"] as? Double {
                        cell.price_usdLabel?.text = "USD $" +
                            String(round(price * 100) / 100)
                }
                }
            }
            
            if indexPath.row == 6 {
                if preferredCoin != coinArray[indexPath.row] {
                    cell.nameLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["name"]
                        as! String
                    cell.symbolLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["asset_id"] as! String
                    cell.coinLabel.af.setImage(withURL: imageArray[indexPath.row]!)
                    if let price = apiCaller.cryptos[coinArray[indexPath.row]]!["price_usd"] as? Double {
                        cell.price_usdLabel?.text = "USD $" +
                            String(round(price * 100) / 100)
                }
                }
            }
            
            if indexPath.row == 7 {
                if preferredCoin != coinArray[indexPath.row] {
                    cell.nameLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["name"]
                        as! String
                    cell.symbolLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["asset_id"] as! String
                    cell.coinLabel.af.setImage(withURL: imageArray[indexPath.row]!)
                    if let price = apiCaller.cryptos[coinArray[indexPath.row]]!["price_usd"] as? Double {
                        cell.price_usdLabel?.text = "USD $" +
                            String(round(price * 100) / 100)
                }
                }
            }
            
            if indexPath.row == 8 {
                if preferredCoin != coinArray[indexPath.row] {
                    cell.nameLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["name"]
                        as! String
                    cell.symbolLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["asset_id"] as! String
                    cell.coinLabel.af.setImage(withURL: imageArray[indexPath.row]!)
                    if let price = apiCaller.cryptos[coinArray[indexPath.row]]!["price_usd"] as? Double {
                        cell.price_usdLabel?.text = "USD $" +
                            String(round(price * 100) / 100)
                }
                }
            }
            
            if indexPath.row == 9 {
                if preferredCoin != coinArray[indexPath.row] {
                    cell.nameLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["name"]
                        as! String
                    cell.symbolLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["asset_id"] as! String
                    cell.coinLabel.af.setImage(withURL: imageArray[indexPath.row]!)
                    if let price = apiCaller.cryptos[coinArray[indexPath.row]]!["price_usd"] as? Double {
                        cell.price_usdLabel?.text = "USD $" +
                            String(round(price * 100) / 100)
                }
                }
            }
            if indexPath.row == 10 {
                if preferredCoin != coinArray[indexPath.row] {
                    print("hello")
                    cell.nameLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["name"]
                        as! String
                    cell.symbolLabel?.text = apiCaller.cryptos[coinArray[indexPath.row]]!["asset_id"] as! String
                    cell.coinLabel.af.setImage(withURL: imageArray[indexPath.row]!)
                    if let price = apiCaller.cryptos[coinArray[indexPath.row]]!["price_usd"] as? Double {
                        cell.price_usdLabel?.text = "USD $" +
                            String(round(price * 100) / 100)
                }
                }
            }
            
            
        }
        
        cell.purchaseAmount.isHidden = true
        cell.confirmButtonOutlet.isHidden = true
        return cell
    }

}



