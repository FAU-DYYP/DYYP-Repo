//
//  LoginViewController.swift
//  DYPP
//
//  Created by luciano scarpaci on 11/2/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
                
        PFUser.logInWithUsername(inBackground: username, password: password)
        {   (user, error) in
            if user != nil {
                        self.performSegue(withIdentifier: "loginViewSegue", sender: nil)
            }
            else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
                
        user.signUpInBackground { (success, error) in
            if error != nil {
                        self.performSegue(withIdentifier: "loginViewSegue", sender: nil)
            }
            else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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