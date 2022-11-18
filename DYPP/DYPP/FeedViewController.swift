//
//  FeedViewController.swift
//  DYPP
//
//  Created by luciano scarpaci on 11/9/22.
//

import UIKit

struct Crypto: Codable{
    var asset_id: String
    var name: String
    var price_usd: Double?
    var volume_1hrs_usd: Float?
    var volume_1day_usd: Float?
}

struct Icon: Codable{
    var asset_id: String
    var id_icon: URL
}

struct CryptoDataStruct{
    var cryptoArray = [Crypto]()
}

final class APICaller{

    var cryptos = [Crypto]()
    
    
    let baseURL = "https://rest.coinapi.io/v1/"
    let apikey = "7D9C95F3-3ADC-4031-A8CF-31E241D77EFB"
    let assets = "assets/"
    let icons = "assets/icons/"
    
    public init() {}
    
    public func getAllCryptoData(completion: @escaping (Result<[Crypto], Error>) -> Void){
        guard let url = URL(string: baseURL + assets + "?apikey=" + apikey) else {
            print("did not get url")
            return
        }
        let task = URLSession.shared.dataTask(with: url){data, _, error in
            guard let data = data, error == nil else {
                print("urlsession error")
                return
            }
            do {
                self.cryptos = try JSONDecoder().decode([Crypto].self, from : data)
                completion(.success(self.cryptos))
                
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}


class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var models = [Crypto]()
    
    //TABLEVIEW
    @IBOutlet weak var tableView: UITableView!
    
    var apiCaller = APICaller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TABLEVIEW
        tableView.dataSource = self
        tableView.delegate = self
        
        apiCaller.getAllCryptoData{ [weak self] result in
            switch result{
            case .success(let data):
                self?.models = data
                
                DispatchQueue.main.async {
                  self?.tableView.reloadData()
                }
            case .failure(let error):
                print("error: \(error)")
            }
        }
        //DEBUG
        print(models)
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if(models.count > 0){
            print(models[indexPath.row].name)
            cell.textLabel?.text = models[indexPath.row].name
        }
        
        return cell
    }

}



