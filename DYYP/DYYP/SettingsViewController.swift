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

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func onToggleMode(_ sender: UISwitch) {
        if #available(iOS 13.0, *) {
            let delegate = UIApplication.shared.windows.first
            if sender.isOn {
                delegate?.overrideUserInterfaceStyle = .dark
                self.appearanceTextLabel.text = "DARK MODE"
                settings.updateUserData(dataKey: "darkMode", dataValue: true)
                return
            }
            delegate?.overrideUserInterfaceStyle = .light
            self.appearanceTextLabel.text = "LIGHT MODE"
            settings.updateUserData(dataKey: "darkMode", dataValue: false)
            return
        } else {
            self.appearanceTextLabel.isHidden = true
            self.appearanceStaticLabel.isHidden = true
            self.modeToggleButton.isHidden = true
        }
    }
    
    @IBAction func onProfileSelect(_ sender: Any) {
        print("onProfileSelect pressed")
        
        // from Parstagram
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        profileImage.image = scaledImage
        //PFFile
        let imageData = profileImage.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        let backUp = PFFileObject(name: "image.png", data: (UIImage(named: "DYYPERV3")?.pngData())!)
        settings.updateUserImage(dataKey: "profileImage", dataValue: (file ?? backUp)!)
        
        dismiss(animated: true, completion: nil)
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
    
    func displayModeCheck(){
        //Default Dark/Light Mode
        if settings.userData["darkMode"] as! Bool == true {
            let delegate = UIApplication.shared.windows.first
            delegate?.overrideUserInterfaceStyle = .dark
        } else {
            let delegate = UIApplication.shared.windows.first
            delegate?.overrideUserInterfaceStyle = .light
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
                                settings.userData = object
                                print(settings.userData)
                                
                            }
                            
                            
                        }
                    }
                }
                print("if user exists before save")
                print(userexists)
                if (userexists == false){
                    settings.userData["user"] = PFUser.current()!
                    settings.userData["username"] = PFUser.current()!.username! as String
                    settings.userData["dyypcoin"] = 0.00
                    settings.userData["darkMode"] = true
                    settings.userData["preferredCoin"] = "BTC"
                    settings.userData["profileImage"] = PFFileObject(name: "image.png", data: (UIImage(named: "DYYPERV3")?.pngData())!)
                    var emptyArray: [String] = []
                    settings.userData["coinsOwned"] = emptyArray
                    settings.userData.saveInBackground { (succeeded, error)  in
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
                    settings.displayModeCheck()
                }
                
            }
    }

    func getUserData(){
            let query = PFQuery(className:"UserData")
            query.getObjectInBackground(withId: settings.userData.objectId ?? "not loaded") { (userData, error) in
                if error == nil {
                    // Success!
                    settings.userData = userData ?? settings.userData
                    print(settings.userData["username"] as! String + " got userData")
                } else {
                    // Fail!
                    print(settings.userData.objectId ?? "not loaded")
                }
            }
            
    }
    func updateUserData(dataKey: String, dataValue: Any){
            let query = PFQuery(className:"UserData")
            query.getObjectInBackground(withId: settings.userData.objectId ?? "not loaded") { (userData, error) in
                if error == nil {
                    // Success!
                    settings.userData[dataKey] = dataValue
                    print(settings.userData["username"] as! String + " updating userData")
                    settings.userData.saveInBackground { (succeeded, error)  in
                        if (succeeded) {
                            // The object has been saved.
                            print("userdata object updated")
                        } else {
                            // There was a problem, check error.description
                        }
                    }
                } else {
                    // Fail!
                    print(settings.userData.objectId ?? "not loaded")
                }
            }
            
    }
    
    //EXPERIMENT
    func updateUserImage(dataKey: String, dataValue: PFFileObject){
            let query = PFQuery(className:"UserData")
            query.getObjectInBackground(withId: settings.userData.objectId ?? "not loaded") { (userData, error) in
                if error == nil {
                    // Success!
                    settings.userData[dataKey] = dataValue
                    print(settings.userData["username"] as! String + " updating userData")
                    settings.userData.saveInBackground { (succeeded, error)  in
                        if (succeeded) {
                            // The object has been saved.
                            print("userdata file updated")
                        } else {
                            // There was a problem, check error.description
                        }
                    }
                } else {
                    // Fail!
                    print(settings.userData.objectId ?? "not loaded")
                }
            }
            
    }
    
    func whiteRemover(string: String) -> String {
        return string.replacingOccurrences(of: " ", with: "_")
    }
    
    func hyphenRemover(string: String) -> String {
        return string.replacingOccurrences(of: "_", with: " ")
    }

    
    func preferredCoinSetup(){
        
        print("Setting up")

        let action = {(action : UIAction) in
            print(action.title)
            let index = (action.title).index(before: (action.title).firstIndex(of: "-")!)
            let name = action.title[...index]
            print(name)
            self.preferredCoinLabel.text = action.title
            settings.updateUserData(dataKey: "preferredCoin", dataValue: name)
        }
        
        // UPDATE LATER - All Coins to List
        let menu = UIMenu(children : [
        UIAction(title: "BTC-Bitcoin", state: .on, handler: action),
        UIAction(title: "BCH-Bitcoin Cash", handler: action),
        UIAction(title: "ETH-Etherium", handler: action),
        UIAction(title: "XRP-Ripple", handler: action),
        UIAction(title: "DOGE-DogeCoin", handler: action),
        UIAction(title: "LTC-Litecoin", handler: action),
        UIAction(title: "XMR-Monero", handler: action),
        UIAction(title: "DOT-Polkadot", handler: action),
        UIAction(title: "XLM-Stellar Lumens", handler: action),
        UIAction(title: "ETC-Ethereum Classic", handler: action)
        ])
        
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
        
        // Display Mode
        if settings.userData["darkMode"] as! Bool == true {
            self.modeToggleButton.isOn = true
            self.appearanceTextLabel.text = "DARK MODE"
            let delegate = UIApplication.shared.windows.first
            delegate?.overrideUserInterfaceStyle = .dark
        } else {
            self.modeToggleButton.isOn = false
            self.appearanceTextLabel.text = "LIGHT MODE"
            let delegate = UIApplication.shared.windows.first
            delegate?.overrideUserInterfaceStyle = .light
        }
        
        // Display Name
        let user = PFUser.current()!
        let name = user.username
        usernameField.placeholder = name

        // Preferred Coin
        preferredCoinSetup()
        if ((settings.userData["preferredCoin"] as! String) ?? "None Selected") == "None Selected" {
            preferredCoinLabel.text = "BTC-Bitcoin"
        }
        
        // Profile Image
        let imageFile = settings.userData["profileImage"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        self.profileImage.af.setImage(withURL: url)
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
