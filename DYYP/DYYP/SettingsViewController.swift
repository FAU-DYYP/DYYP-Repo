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
    
    @IBOutlet weak var preferredCoinSelect: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var preferredCoinLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    // initializing settings global class
    //var settings = [PFObject]()
    
    
    // profile pic change
    @IBAction func onProfileSelect(_ sender: Any) {
        print("onProfileSelect pressed")
        
        let selector = UIImagePickerController()
        selector.delegate = self
        selector.allowsEditing = true
        
        selector.sourceType = .photoLibrary
        
        present(selector, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let profilePic = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = profilePic.af_imageScaled(to: size)
        
        profileImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    // username change
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
            let alert = UIAlertController(title: "INVALID", message: "Please provide a username to change.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // preferred coin
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
    
    // theme selection
    @IBAction func onTheme(_ sender: Any) {
        print("onTheme pressed")
    }
    
    // logging out
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
