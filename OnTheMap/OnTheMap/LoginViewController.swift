//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Gamal Gamaleldin on 2/12/19.
//  Copyright © 2019 el3ankaboot. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
 
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.loadLocations()
        
        
    }
    
    
    
    
    //MARK: Actions
    
    @IBAction func loginPressed(_ sender: Any) {
        usernameTextField.isEnabled = false
        passwordTextField.isEnabled = false
        loginButton.isEnabled = false
        signupButton.isEnabled = false
        
        
        UdacityClient.login(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse(success:error:))
        
        
        
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        if success {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
            }
        } else {
            
             showLoginFailure(message: error?.localizedDescription ?? "Wrong Username or password")
            // I made the default case to be wrong username or password , because in udacity client class , when there is a problem in user credentials I return success false and error nil
            //That's why if we entered the else part (success = false) when the error is nil , the user credentials is the error.
            
            DispatchQueue.main.async {
                self.usernameTextField.isEnabled = true
                self.passwordTextField.isEnabled = true
                self.loginButton.isEnabled = true
                self.signupButton.isEnabled = true
            }
            
        }
    }
    
    func showLoginFailure(message: String) {
         DispatchQueue.main.async {
            let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
       
             self.show(alertVC, sender: nil)
        }
       
    }
    
    
    
    @IBAction func signupPressed(_ sender: Any) {
        if let url = URL(string: "https://auth.udacity.com/sign-up") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
}

