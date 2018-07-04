//
//  RegisterViewController.swift
//  bucketlist
//
//  Created by Clement  Wekesa on 07/06/2018.
//  Copyright © 2018 Clement  Wekesa. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
        guard
            let username = username.text,
            let password = password.text,
            let email = email.text
            else {
                print("Username or password is missing!!!!")
                return
        }
        
        let registerDetails = ["username": username, "password": password, "email": email]
        NetworkClient.standard.post(url: "/auth/register", data: registerDetails) { (status) -> (Void) in
            if status {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "goToBucketlist", sender: nil)
                }
            }
            // TO DO Show an alert
        }
    }
}
