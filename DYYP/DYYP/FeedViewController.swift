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
        cell.dollarsign.isHidden = true
        
        var preferredCoin = (settings.userData["preferredCoin"] ?? "BTC") as! String

        
        let coinArray = [preferredCoin, "BCH", "ETH", "XRP", "DOGE", "LTC", "XMR", "DOT", "XLM", "ETC"]
        let imageArray = [
            apiCaller.crypto_icons[preferredCoin],
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
        
        
        if preferredCoin == "None Selected" {
            preferredCoin = "BTC"
        }
        
        
        if(apiCaller.cryptos.count > 0){
            var currentCoin = coinArray[indexPath.row]
            var currentImg = imageArray[indexPath.row]
            cell.purchaseAmount.tag = indexPath.row
            if preferredCoin == currentCoin && indexPath.row != 0 {
                currentCoin = "BTC"
                currentImg = apiCaller.crypto_icons["BTC"]
            }
            cell.nameLabel?.text = apiCaller.cryptos[currentCoin]!["name"] as! String
            cell.symbolLabel?.text = apiCaller.cryptos[currentCoin]!["asset_id"] as! String
            cell.coinLabel.af.setImage(withURL: currentImg!)
            if let price = apiCaller.cryptos[currentCoin]!["price_usd"] as? Double {
                cell.price_usdLabel?.text = "USD $" +
                    String(round(price * 100) / 100)
            }
        }
        
        cell.purchaseAmount.isHidden = true
        cell.confirmButtonOutlet.isHidden = true
        return cell
    }

}



