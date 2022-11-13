//
//  APICaller.swift
//  DYPP
//
//  Created by luciano scarpaci on 10/14/22.
//

import Foundation


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

