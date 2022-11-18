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
    var apiCaller = APICaller()
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
//    var apiCaller = APICaller()
    
    override func viewDidLoad() {
        print("viewDidLoad-entered")
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        apiCaller.loadCryptoData()
        self.tableView.reloadData()
        
        super.viewDidLoad()

        print("viewDidLoad-exit")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 115
        print("viewDidAppear")
        
        //trigger api, will refresh when screen accessed
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView numberOfRowsInSection", section)
        return 15 //TEMPORARY
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView cellForRowAt", indexPath)

        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell") as! CoinCell
        
        print(indexPath.row)
        if(cryptos.count > 0){
            print(cryptos.count)
            cell.coinNameLabel.text = cryptos["Bitcoin"]!["name"] as! String
            

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
