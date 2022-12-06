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
        
    @IBOutlet weak var totalCoinsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalEarningsLabel: UILabel!
    
    let walletRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.reloadData()
        
        apiCaller.loadCryptoData()
        apiCaller.loadCryptoIcons()
        
        loadWallet()
        
        walletRefreshControl.addTarget(self, action: #selector(loadWallet), for: .valueChanged)
        tableView.refreshControl = walletRefreshControl
        
        // Change Values for Specs
        let totalCoins = settings.userData["coinsOwned"]
        totalCoinsLabel.text = "69"
        totalEarningsLabel.text = "420"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 115
        self.tableView.reloadData()
        self.loadWallet()
    }
    
    @objc func loadWallet() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView.reloadData()
            self.walletRefreshControl.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 //TEMPORARY
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell") as! CoinCell
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
            if preferredCoin == currentCoin && indexPath.row != 0 {
                currentCoin = "BTC"
                currentImg = apiCaller.crypto_icons["BTC"]
            }
            cell.coinNameLabel?.text = apiCaller.cryptos[currentCoin]!["name"] as! String
            cell.informationLabel?.text = apiCaller.cryptos[currentCoin]!["asset_id"] as! String
            cell.coinLogoImage.af.setImage(withURL: currentImg!)
            var owned = (settings.userData[cell.coinNameLabel.text ?? "dyypcoin"] as? Double ?? 0.00)
            cell.ownedLabel.text = String(owned)
        }
        
        cell.purchaseAmount.isHidden = true
        cell.confirmButtonOutlet.isHidden = true
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
