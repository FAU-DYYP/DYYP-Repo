//
//  LoadingViewController.swift
//  DYYP
//
//  Created by Peyton Adkins on 12/6/22.
//

import UIKit
import Parse
import AlamofireImage

class LoadingViewController: UIViewController {
    
    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var userReady = false
        var apiReady = false
        var name = ""
        var username = ""
        var num = 0

        // Do any additional setup after loading the view.
//        while userReady == false && apiReady == false {
//            name = apiCaller.cryptos["BTC"]?["name"] as? String ?? "Test"
//            username = settings.userData["username"] as? String ?? "Test"
//            if  (username != "Test") {
//                userReady = true
//                print(userReady)
//            }
//            if  (name != "Test") {
//                apiReady = true
//                print(apiReady)
//            }
//            print(String(num))
//            num = num + 1
//        }
        
        //self.segue()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let feedView = main.instantiateViewController(withIdentifier: "UITabBarController")
        //setting window
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = feedView
        //window?.rootViewController = feedView
    }
    
    func segue() {
        self.performSegue(withIdentifier: "navSegue", sender: nil)
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
