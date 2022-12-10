//
//  APICaller.swift
//  DYPP
//
//  Created by luciano scarpaci on 10/14/22.
//

import Foundation

//struct Crypto: Codable{
//    var asset_id: String
//    var name: String
//    var price_usd: Double?
//    var volume_1hrs_usd: Float?
//    var volume_1day_usd: Float?
//}
//struct Icon: Codable{
//    var asset_id: String
//    var id_icon: URL
//}

/* asset json format
{
    "asset_id": "BTC",
    "name": "Bitcoin",
    "type_is_crypto": 1,
    "data_start": "2010-07-17",
    "data_end": "2019-11-03",
    "data_quote_start": "2014-02-24T17:43:05.0000000Z",
    "data_quote_end": "2019-11-03T17:55:07.6724523Z",
    "data_orderbook_start": "2014-02-24T17:43:05.0000000Z",
    "data_orderbook_end": "2019-11-03T17:55:17.8592413Z",
    "data_trade_start": "2010-07-17T23:09:17.0000000Z",
    "data_trade_end": "2019-11-03T17:55:11.8220000Z",
    "data_symbols_count": 22711,
    "volume_1hrs_usd": 102894431436.49,
    "volume_1day_usd": 2086392323256.16,
    "volume_1mth_usd": 57929168359984.54,
    "price_usd": 9166.207274778093436220194944
  },
 
*/


//struct CryptoDataStruct {
//    var cryptoArray = [Crypto]()
//}

var apiCaller = APICaller()

final class APICaller{
    
    public var cryptos = [String:[String:Any]]()
    public var crypto_icons = [String:URL]()
    
    let baseURL = "https://rest.coinapi.io/v1/"
    let apikey = "7D9C95F3-3ADC-4031-A8CF-31E241D77EFB" // Main Key
    //let apikey = "6B2D17E3-07E0-47DF-A44E-688437365EA9" // Peyton's Key
    //let apikey = "5B0BFEBF-34C3-4627-830D-7F5E4DA829CE" // Dustin's key
    let assets = "assets/"
    let icons = "assets/icons/tiny/"
    
    public init() {
        print("APICaller init")
    }
    
    public func loadCryptoData() {
        
        guard let assetsUrl = URL(string: baseURL + assets + "?apikey=" + apikey) else {
            print("did not get url")
            return
        }
        
        let request = URLRequest(url: assetsUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        print("before let task")
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                print("before JSONSerialization")
                let cryptosArray = try! JSONSerialization.jsonObject(with: data) as! [[String: Any]]

                for item in cryptosArray
                    {
                        //add array items to dictionary as key with value
                        self.cryptos[item["asset_id"] as! String] = item
                    }
                print("before access cryptos")
                print(self.cryptos.count)
                print(self.cryptos["BTC"])
            }
        }
        task.resume()
    }
    public func loadCryptoIcons() {
        
        guard let iconsUrl = URL(string: baseURL + icons + "?apikey=" + apikey) else {
            print("did not get url")
            return
        }
        
        let request = URLRequest(url: iconsUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        print("before let task")
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                print("before JSONSerialization")
                let iconsArray = try! JSONSerialization.jsonObject(with: data) as! [[String: String]]

                for item in iconsArray
                    {
                        //add array items to dictionary as key with value
                        let asset_id = item["asset_id"]!
                        let asset_url = URL(string: item["url"]!)
                        //crypto_icons[item["asset_id"] as! String] = item
                        self.crypto_icons[asset_id] = asset_url
                    
                    }
                print("before access cryptos")
                print(self.crypto_icons.count)
                print(self.crypto_icons["BTC"])
            }
        }
        task.resume()
    }
}

