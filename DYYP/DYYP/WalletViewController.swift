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
    @IBOutlet weak var dyyperTextBubble: UIImageView!
    @IBOutlet weak var sellButtonOutlet: UIButton!
    let walletRefreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dyyperTextBubble.isHidden = false
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.reloadData()
        
        loadWallet()
        
        walletRefreshControl.addTarget(self, action: #selector(loadWallet), for: .valueChanged)
        tableView.refreshControl = walletRefreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //dyyper
        dyyperTextBubble.isHidden = false
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 115
        self.tableView.reloadData()
        self.loadWallet()
    }
    
    @objc func loadWallet() {
        print("ran loadWaller")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView.reloadData()
            self.walletRefreshControl.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var coins = [String]()
        
        if (settings.userData["coinsOwned"]) != nil {
            let totalEarnings = settings.userData["moneyEarned"] as! Double
            totalEarningsLabel.text = "$ " + String(totalEarnings)
            coins = (settings.userData["coinsOwned"] as! Array<String>)
            if coins.count <= 1{
                dyyperTextBubble.isHidden = false
            }
            return coins.count - 1
        } else {
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell") as! CoinCell
        
        var currentCoins = [String]()
        var total = 0.00
        
        if (settings.userData["coinsOwned"]) != nil {
            currentCoins = (settings.userData["coinsOwned"] as! Array<String>)
            total = settings.getTotalValue()
            if (currentCoins.count <= 1) && (currentCoins[0] == "DYYP"){
                dyyperTextBubble.isHidden = false
            }
        } else {
            currentCoins = ["DYYP", "BCH", "ETH", "XRP", "DOGE", "LTC", "XMR", "DOT", "XLM", "ETC"]
            print("Default")
        }
        
        
        if (currentCoins.count <= 1){
            //dyyper appear
            dyyperTextBubble.isHidden = false
        } else if (currentCoins.count > 1) {
            //dyyper hide
            dyyperTextBubble.isHidden = true
            
            if(apiCaller.cryptos.count > 0){
                var currentCoin = currentCoins[indexPath.row + 1]
                var currentImg = apiCaller.crypto_icons[currentCoins[indexPath.row + 1]]

            
                
                cell.coinNameLabel?.text = apiCaller.cryptos[currentCoin]!["name"] as! String
                cell.informationLabel?.text = apiCaller.cryptos[currentCoin]!["asset_id"] as! String
                cell.coinLogoImage.af.setImage(withURL: currentImg!)
                let coinName = settings.whiteRemover(string: cell.coinNameLabel.text ?? "DYYP")
                var owned = (settings.userData[coinName] as? Double ?? 0.00)
                let price = apiCaller.cryptos[currentCoin]!["price_usd"] as! Double
                
                totalCoinsLabel.text = "$ " + String(total)
                
                var roundedOwned = Double(round(10000 * owned) / 10000)
                cell.ownedLabel.text = (String(roundedOwned))
            }
        }
        var moneyEarned = settings.userData["moneyEarned"] as! Double
        let roundedEarned = Double(round(10000 * moneyEarned) / 10000)
        totalEarningsLabel.text = "$ " + String(roundedEarned)
        cell.purchaseAmount.isHidden = true
        cell.confirmButtonOutlet.isHidden = true
        
        if cell.reload == true{
            print("running self.loadWallet")
            self.loadWallet()
            cell.reload = false
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
