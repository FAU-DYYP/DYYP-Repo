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
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedCell
        
        if(cryptos.count > 0){
            cell.nameLabel?.text = cryptos["Bitcoin"]!["name"] as! String
            
            if let showPrice = cryptos["Bitcoin"]!["price_usd"] as? Double {
                cell.price_usdLabel?.text = "USD $" + String(round(showPrice * 1000) / 1000)
            }
            
            if let show1hrVolume = cryptos["Bitcoin"]!["volume_1hrs_usd"] as? Float {
                cell.volume_1hrs_usdLabel?.text = "volume 1hr $" +
                    String(round(show1hrVolume * 1000) / 1000)
            }
            
            if let show1dayVolume =
                cryptos["Bitcoin"]!["volume_1hrs_usd"] as? Float {
                cell.volume_1day_usdLabel?.text = "volume 1day $" +
                    String(round(show1dayVolume * 1000) / 1000)
            }
            
            //cell.volume_1hrs_usdLabel?.text = "\(models[indexPath.row].volume_1hrs_usd)"
            //cell.volume_1day_usdLabel?.text = "\(models[indexPath.row].volume_1day_usd)"
        }
        
        return cell
    }

}



