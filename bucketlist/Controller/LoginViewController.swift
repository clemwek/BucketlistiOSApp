//
//  ViewController.swift
//  bucketlist
//
//  Created by Clement  Wekesa on 07/06/2018.
//  Copyright © 2018 Clement  Wekesa. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        guard
            let username = username.text,
            let password = password.text
            else {
                print("Username or password is missing!!!!")
                return
        }
        
        let loginDetails = ["username": username, "password": password]
        NetworkClient.standard.post(url: "/auth/login", data: loginDetails) { (status) -> (Void) in
            if status {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "goToBucketlist", sender: nil)
                }
            }
            // TO DO Show an alert
        }
    }
    
    
}

