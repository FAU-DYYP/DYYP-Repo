//
//  LoginViewController.swift
//  DYPP
//
//  Created by luciano scarpaci on 11/2/22.
//

import UIKit
import Parse
import AlamofireImage

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
                
        PFUser.logInWithUsername(inBackground: username, password: password)
        {   (user, error) in
            if user != nil {
                settings.parseUserData()
                
                self.performSegue(withIdentifier: "loginViewSegue", sender: nil)
            }
            else {
                print("Error: \(error?.localizedDescription)")
                //from Apple Developer
                let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        if usernameField.text != "" && passwordField.text != "" {
            user.username = usernameField.text
            user.password = passwordField.text
            user.signUpInBackground { (success, error) in
                if error != nil {
                    settings.parseUserData()
                    self.performSegue(withIdentifier: "loginViewSegue", sender: nil)
                }
                else {
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }
        else {
            //from Apple Developer
            let alert = UIAlertController(title: "ERROR", message: "username/email required.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Default to dark mode
        let delegate = UIApplication.shared.windows.first
        delegate?.overrideUserInterfaceStyle = .dark
        
        //Secure password
        passwordField.isSecureTextEntry = true
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
