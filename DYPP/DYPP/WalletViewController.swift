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
    //func getModels(){
      //  return models
    //}
    
    @IBOutlet weak var tableView: UITableView!
    
//    var apiCaller = APICaller()
    
    override func viewDidLoad() {
        print("viewDidLoad-entered")
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        
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
        return 5 //TEMPORARY
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView cellForRowAt", indexPath)

        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell") as! CoinCell
        
        print(indexPath.row)
        if(apiCaller.cryptos.count > 0){
            print(apiCaller.cryptos.count)

//            print(models[indexPath.row].name)
  //          cell.coinNameLabel.text = models[indexPath.row].name
            

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
