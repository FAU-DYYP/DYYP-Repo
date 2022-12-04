//
//  SettingsViewController.swift
//  DYPP
//
//  Created by luciano scarpaci on 11/9/22.
//

import UIKit
import Parse
import AlamofireImage

var settings = SettingsViewController()

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var preferredCoinLabel: UILabel!
    @IBOutlet weak var preferredCoinSelect: UIButton!
    
    var userDataId = ""
    var userData = PFObject(className: "userData")
    //public var userDataDict = [String:Any]()
    
    
    @IBAction func onProfileSelect(_ sender: Any) {
        print("onProfileSelect pressed")
    }
    
    @IBAction func onDisplayChange(_ sender: Any) {
        if usernameField.text != "" {
            let user = PFUser.current()!
            user.username = usernameField.text
            
            let name = user.username
            print (name ?? "username")
            usernameField.text = ""
            
            user.saveInBackground()
        }
        else {
            //from Apple Developer
            let alert = UIAlertController(title: "INVALID", message: "Please provide a username to change.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func parseUserData(){
        var userData = PFObject(className:"UserData")
        userData["user"] = PFUser.current()!
        userData["username"] = PFUser.current()!.username! as String
        userData["BTCowned"] = 10
        var userexists = false
        
        let query = PFQuery(className: "UserData")
        query.findObjectsInBackground{(objects, error) -> Void in
            if error == nil {
                if let returnedobjects = objects {
                    for object in returnedobjects{
                        if object["username"] as! String == PFUser.current()!.username! as String {
                            userexists = true
                            self.userDataId = object.objectId!
                            print(self.userDataId)
                            self.userData = object
                        }
                        
                    }
                }
            }
            print("if user exists before save")
            print(userexists)
            if (userexists == false){
                userData.saveInBackground { (succeeded, error)  in
                    if (succeeded) {
                        // The object has been saved.
                        //userData.pinInBackground()
                        self.userData = userData
                        print("userdata object saved")
                    } else {
                        // There was a problem, check error.description
                    }
                }
                
            }
            else{
                print("user exists")
                //userData.pinInBackground()
            }
            
        }
        
        
        
    }
    
    func getUserData(){
        let query = PFQuery(className:"userData")
        query.getObjectInBackground(withId: self.userDataId) { (userData, error) in
            if error == nil {
                // Success!
                //userData?.pinInBackground()
                //print("pinning in background")
                self.userData = userData!
            } else {
                // Fail!
            }
        }
        
    }
    func updateUserData(){
        let query = PFQuery(className:"userData")
        query.getObjectInBackground(withId: self.userDataId) { (userData, error) in
            if let error = error {
                print(error.localizedDescription)
                print("error spot 1")
                print(self.userDataId)
            } else if var userData = userData {
                userData = self.userData
                userData.saveInBackground()
            }
        }
    }
    /*
    func updateUserData(){
        let query = PFQuery(className:"userData")
        query.getObjectInBackground(withId: self.userDataId) { (userData: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                print("error spot 1")
                print(self.userDataId)
            } else if var userData = userData {
                userData = self.userData
                userData.saveInBackground()
            }
        }
    }
    */
    func preferredCoinSetup(){

        let action = {(action : UIAction) in
            print(action.title)
            self.preferredCoinLabel.text = action.title
        }
        
        // UPDATE LATER - All Coins to List
        let menu = UIMenu(children : [
        UIAction(title: "None Selected", state: .on, handler: action),
        UIAction(title: "Opt 1", handler: action),
        UIAction(title: "Opt 2", handler: action)])
        
        preferredCoinSelect.menu = menu
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

        // Display Name
        let user = PFUser.current()!
        let name = user.username
        usernameField.placeholder = name
        getUserData()
        
        
        // Preferred Coin
        preferredCoinSetup()
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
