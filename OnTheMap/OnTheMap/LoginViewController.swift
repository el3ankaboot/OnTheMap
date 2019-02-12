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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            
        }
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        if let url = URL(string: "https://auth.udacity.com/sign-up") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
}

