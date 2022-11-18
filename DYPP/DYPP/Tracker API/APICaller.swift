//
//  APICaller.swift
//  DYPP
//
//  Created by luciano scarpaci on 10/14/22.
//

import Foundation

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


struct CryptoDataStruct {
    var cryptoArray = [Crypto]()
}

final class APICaller{
    //let shared = APICaller()
    
    /*
    struct coinViewModel{
        let name: String
        let price_usd: String
    }
     */
    var cryptos = [Crypto]()

    
    
    let baseURL = "https://rest.coinapi.io/v1/"
    let apikey = "7D9C95F3-3ADC-4031-A8CF-31E241D77EFB"
    let assets = "assets/"
    let icons = "assets/icons/"
    
    public init() {
        print("APICaller init")
    }
    
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
                //global.CryptoDataStruct.
                completion(.success(self.cryptos))
                
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}



/*
 
 struct Response: Codable {
     let results: coinAPIResult
     let status: String
 }

 struct coinAPIResult: Codable{
     
 }
 
 
 struct CoinData: Decodable {
     let rate: Double
 }

 func didUpdatePrice(price: String, currency: String) {
     
     DispatchQueue.main.async {
         //self.bitcoinLabel.text = price
         //self.currencyLabel.text = currency
     }
 }

 func didFailWithError(error: Error) {
     print(error)
 }
 */

