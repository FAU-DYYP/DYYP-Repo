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
    var userData = PFObject(className:"UserData")
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var preferredCoinLabel: UILabel!
    @IBOutlet weak var displayNameStaticLabel: UILabel!
    @IBOutlet weak var preferredCoinStaticLabel: UILabel!
    @IBOutlet weak var preferredCoinSelect: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var appearanceStaticLabel: UILabel!
    @IBOutlet weak var appearanceTextLabel: UILabel!
    @IBOutlet weak var modeToggleButton: UISwitch!
    
    @IBAction func onToggleMode(_ sender: UISwitch) {
        if #available(iOS 13.0, *) {
            let delegate = UIApplication.shared.windows.first
            if sender.isOn {
                delegate?.overrideUserInterfaceStyle = .dark
                self.appearanceTextLabel.text = "DARK MODE"
                return
            }
            delegate?.overrideUserInterfaceStyle = .light
            self.appearanceTextLabel.text = "LIGHT MODE"
            return
        } else {
            self.appearanceTextLabel.isHidden = true
            self.appearanceStaticLabel.isHidden = true
            self.modeToggleButton.isHidden = true
        }
    }
    
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
            usernameField.placeholder = name
            
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

            var userexists = false
            
            let query = PFQuery(className: "UserData")
            query.findObjectsInBackground{(objects, error) -> Void in
                if error == nil {
                    if let returnedobjects = objects {
                        for object in returnedobjects{
                            print(object["username"]!)
                            print(object.objectId!)
                            if object["username"] as! String == PFUser.current()!.username! as String {
                                userexists = true
                                self.userData = object
                                print(self.userData)
                            }
                            
                        }
                    }
                }
                print("if user exists before save")
                print(userexists)
                if (userexists == false){
                    self.userData["user"] = PFUser.current()!
                    self.userData["username"] = PFUser.current()!.username! as String
                    self.userData["dyypcoin"] = 0.00
                    self.userData.saveInBackground { (succeeded, error)  in
                        if (succeeded) {
                            // The object has been saved.
                            print("userdata object saved")
                        } else {
                            // There was a problem, check error.description
                        }
                    }
                    
                }
                else{
                    print("user exists")
                }
                
            }
    }

    func getUserData(){
            let query = PFQuery(className:"UserData")
            query.getObjectInBackground(withId: self.userData.objectId ?? "not loaded") { (userData, error) in
                if error == nil {
                    // Success!
                    self.userData = userData ?? self.userData
                    print(self.userData["username"] as! String + " got userData")
                } else {
                    // Fail!
                    print(self.userData.objectId ?? "not loaded")
                }
            }
            
    }
    func updateUserData(dataKey: String, dataValue: Any){
            let query = PFQuery(className:"UserData")
            query.getObjectInBackground(withId: self.userData.objectId ?? "not loaded") { (userData, error) in
                if error == nil {
                    // Success!
                    self.userData[dataKey] = dataValue
                    print(self.userData["username"] as! String + " updating userData")
                    self.userData.saveInBackground { (succeeded, error)  in
                        if (succeeded) {
                            // The object has been saved.
                            print("userdata object updated")
                        } else {
                            // There was a problem, check error.description
                        }
                    }
                } else {
                    // Fail!
                    print(self.userData.objectId ?? "not loaded")
                }
            }
            
    }

    
    func preferredCoinSetup(){
        
        print("Setting up")

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
        
        //Default Dark Mode
        modeToggleButton.isOn = true
        appearanceTextLabel.text = "DARK MODE"
        
        // Display Name
        let user = PFUser.current()!
        let name = user.username
        usernameField.placeholder = name

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
