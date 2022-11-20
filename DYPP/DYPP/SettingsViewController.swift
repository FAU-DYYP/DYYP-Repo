//
//  SettingsViewController.swift
//  DYPP
//
//  Created by luciano scarpaci on 11/9/22.
//

import UIKit
import Parse
import AlamofireImage

class SettingsViewController: UIViewController {
    
    
    @IBAction func onProfileSelect(_ sender: Any) {
        print("onProfileSelect pressed")
    }
    
    
    @IBAction func onDisplay(_ sender: Any) {
        print("onDisplay pressed")
    }
    
    @IBAction func onPreferred(_ sender: Any) {
        print("onPreferred pressed")
    }
    
    @IBAction func onTheme(_ sender: Any) {
        print("onTheme pressed")
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        //setting window
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        delegate.window?.rootViewController = loginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
